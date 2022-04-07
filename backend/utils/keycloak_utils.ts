import KeycloakConnect from 'keycloak-connect';
import {Token, Grant} from 'keycloak-connect';
import { MemoryStore } from 'express-session';
import * as express from 'express';
import {log} from './logger_utils';

/* Environment variables that are passed to the server */
const KEYCLOAK_HOST = 'http://nginx/auth/';
const CLIENT_ID     = "cap-app";
const CLIENT_SECRET = 'aQX4Vdbe7PhQTPCwRdeOwIdQzbpGkOdw';  
const REALM_NAME    = 'CAP';

/* Global Keycloak Configuration */
export const kc_config = {
    clientId: CLIENT_ID,
    credentials: {
        secret: CLIENT_SECRET
    },
    'confidential-port': 80,
    'auth-server-url': KEYCLOAK_HOST,
    'resource': "", 
    'ssl-required': "",
    'bearer-only': true,
    realm: REALM_NAME
}


interface KCUserData {
    keycloak_id: string,
    username: string,
    email_verified : boolean
};
interface KCUserInfoRequest{
    user : KCUserData | null,
    error : any | null
}



/* Keycloak and the memory storage objects */
export const memoryStore = new MemoryStore();                       
export const keycloak = new KeycloakConnect({ store: memoryStore }, kc_config);


/* Disable link forwarding since we are using a pure API */
keycloak.redirectToLogin = function(req) { return false; };



/**
 * Protector is a function that can be passed to the Keycloak.protect(). 
        Protector checks if a user is authorized and might do extra stuff later as maybe editing the database.
        However, for this application, it is enough to check if a user is authorized or not as the given role. 
        Therefore, the developer can have the option to either call this function and pass the role to it, or use the Keycloak.protect("realm:<role>") middleware directly.
        This protector is a mid processing unit to interpolate some data or gather some data about the user. And it is totally useless for the scope of this project. I just realised this.
*/
export const protector: KeycloakConnect.GuardFn = (token, req) => {
    console.log(`realm:student: `, token.hasRole(`realm:student`));
    return token.hasRole(`realm:student`);
}

/**
 * An express middleware to check if the user is authenticated (Has a grant to be more specific).
 * Note that Protect() can also check for authenticated user. 
 *  But we also may need to define our own checking middleware for the future usage.
 * @param req Request object
 * @param res Response object
 * @param next express Next object
 */
export const isAuth: express.RequestHandler = (req: express.Request, res: express.Response, next : express.NextFunction) => {
    keycloak.getGrant(req, res).then((grant) => {
        console.log("[INFO]: User is authenticated.");
        next();
    }).catch( err => {
        console.log("[INFO]: User is not authenticated. Keycloak.Grant can't be found in the session");
        next(err);
    });
}


/**
 * An express middleware to check if the user is NOT authenticated. 
 *  This can be used in cases for an eplicit check. 
 *  When it is a must for the user not to be authenticated.
 * @param req Request object
 * @param res Response object
 * @param next express Next object
 */
 export const isUnauth: express.RequestHandler = (req: express.Request, res: express.Response, next : express.NextFunction) => {
    keycloak.getGrant(req, res).then((grant) => {
        console.log("[INFO]: User is authenticated.");
        let err = new Error("User is already logged in");
        next(err);
    }).catch( err => {
        console.log("[INFO]: User is not authenticated. Keycloak.Grant can't be found in the session");
        next();
    });
}


/**
 * A function that extracts the keycloak data stored in the grant. Mostly it contain the keycloak ID of the 
 *  logged in user.
 * @param req 
 * @param res 
 */
export async function getUserData (req: express.Request, res : express.Response) : Promise<KCUserInfoRequest> {
    try{
        let grant : Grant = await keycloak.getGrant(req, res);
        const at : Token | string = grant.access_token as Token;
        const rt : Token | string = grant.refresh_token as Token;
        log("DEBUG", `Access Token: ${at}`);

        const userInfo = await keycloak.grantManager.userInfo(at) as any;
        const userData : KCUserData = { 
            keycloak_id: userInfo.sub, 
            username: userInfo.preferred_username, 
            email_verified : userInfo.email_verified 
        } as KCUserData;

        return {error : null, user : userData} as KCUserInfoRequest;
    }catch(error){
        return {error : error, user : null} as KCUserInfoRequest;
    }
};
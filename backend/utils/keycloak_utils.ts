import KeycloakConnect from 'keycloak-connect';
import {Token, Grant} from 'keycloak-connect';
import { MemoryStore } from 'express-session';
import * as express from 'express';
import {log} from './logger_utils';
import { execReq } from './http_utils';
import qs from 'qs';
import { Stream } from 'stream';

/* Environment variables that are passed to the server */
const KEYCLOAK_HOST : string = process.env.KEYCLOAK_HOST || 'http://nginx/auth/';
const CLIENT_ID     : string = process.env.CLIENT_ID     || "cap-app";
const CLIENT_SECRET : string = process.env.CLIENT_SECRET || 'aQX4Vdbe7PhQTPCwRdeOwIdQzbpGkOdw';  
const REALM_NAME    : string = process.env.REALM_NAME    || 'CAP';

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
};


// ------------------------- Constants Section

/* Keycloak and the memory storage objects */
export const memoryStore = new MemoryStore();                       
export const keycloak = new KeycloakConnect({ store: memoryStore }, kc_config);
export const appRoles : string[] = ["admin", "demonstrator", "student"];


/* Disable link forwarding since we are using a pure API */
keycloak.redirectToLogin = function(req) { return false; };


// -------------------------- Interfaces (Objects templates)
/**
 * The Keycloak User Data.
 */
interface KCUserData {
    keycloak_id: string,
    username: string,
    email_verified? : boolean,
    roles : string[],
    email? : string
};

/**
 * Encapsulate the User data result or error.  This object is returned when the getUserData() is called.
 */
interface KCUserInfoRequest{
    user : KCUserData | null,
    error : any | null
};


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
        const at : Token = grant.access_token as Token;
        const rt : Token = grant.refresh_token as Token;

        if(grant.isExpired() || at.isExpired()){ // An extra validation layer.
            throw new Error("User authentication token is expired");
        }

        let userRoles : string[] = [];
        for(const role of appRoles){
            userRoles = (at.hasRealmRole(role))? [...userRoles,role] : userRoles ;
        }
        
        const userInfo = await keycloak.grantManager.userInfo(at) as any;
        const userData : KCUserData = { 
            keycloak_id: userInfo.sub, 
            username: userInfo.preferred_username, 
            email_verified : userInfo.email_verified,
            roles : userRoles
        } as KCUserData;

        return {error : null, user : userData} as KCUserInfoRequest;
    }catch(error){
        return {error : error, user : null} as KCUserInfoRequest;
    }
};


/**
 * A helper function for getting an access token of the current client.
 */
export async function createClientAccessToken(): Promise<string>{
    /* Get access token for the client (cap-app) so we can request data from keycloak using that client */
    let reqRes = await execReq(
        "post", 
        `${KEYCLOAK_HOST}realms/${REALM_NAME}/protocol/openid-connect/token`, 
        qs.stringify({grant_type: 'client_credentials', client_id: CLIENT_ID, client_secret: CLIENT_SECRET}),
        { 'Content-Type': 'application/x-www-form-urlencoded'}
    );
    if(reqRes.error){
        throw new Error(reqRes.error);
    }
    return reqRes.result.data.access_token;
}


/**
 * 
 * Get all users that are in the realm. 
 * @param roles - An array of roles to search the users for. If no role is given, we use the default three roles in 'appRoles' defined in the module
 * @returns an array of keycloak user data.
 */
export async function getAllUsersData(roles? : string[]) : Promise<KCUserData[]> {
    var at : string = "";
    try{
        at = await createClientAccessToken();
    }catch(error){
        log("ERROR", error as string);
        return [];
    }

    /* Get users from keycloak by role (faster).*/
    const usersMap = new Map<string, KCUserData>(); // avoid redundancy of roles (iff user has multiple roles)
    roles = (roles)? roles : appRoles;              // Roles is given (defined), then we only get users of this role
    for(const role of roles){
        /* Get the users by role */
        let reqRes = await execReq(
            "get", 
            `${KEYCLOAK_HOST}admin/realms/${REALM_NAME}/roles/${role}/users`,
            undefined,
            {'Content-Type': 'application/json', Authorization: 'Bearer ' + at }
        );
        if(reqRes.error){
            log("ERROR", reqRes.error);
            continue;
        }

        /* For all the users we got, add them to our map or update the map roles*/
        reqRes.result.data.forEach((user : any) => {
            var userRoles = [role];
            if(usersMap.has(user.id)){ // If we already got the user, then we just edit its role
                const ukc : KCUserData = usersMap.get(user.id) as KCUserData;
                userRoles = userRoles.concat(ukc.roles);
            }
            usersMap.set(user.id, {  // add/update the user (role is only updated if it exists) 
                keycloak_id: user.id, 
                username: user.username, 
                email_verified : user.emailVerified,
                roles : userRoles
            } as KCUserData)
        });
    }

    /* Transform the map into an array.*/
    var usersData : KCUserData[] = [];
    usersMap.forEach( (data : KCUserData) => {
        usersData = usersData.concat(data);
    });
    return usersData;
}




/**
 * Create multiple users in keycloak given an array 
 * of userRepresentation (https://www.keycloak.org/docs-api/15.0/rest-api/index.html#_userrepresentation)
 * 
 * Returns:
 *  A map containing the usernames and their relative passwords
 * 
 */
export async function createUsers(users: KCUserData[]) : Promise<Map<string, string>> {
    /* Creating client access token */
    var at : string = "";
    try{
        at = await createClientAccessToken();
    }catch(error){
        log("ERROR", error as string);
        return new Map();
    }

    /* Creating user */
    var insertedUsers : Map<string, string> = new Map<string, string>();
    for(const user of users){
        if(insertedUsers.has(user.username)){
            log("DEBUG", "multiple users are given that are redundant");
            continue;
        }
        let password = (Math.random() + 1).toString(36).substring(7);
        let userRepr = {
            id : user.keycloak_id,
            email : user.email,
            emailVerified : user.email_verified,
            enabled : true,
            realmRoles : user.roles,
            username : user.username,
            credentials : [{type:"password", value: password, temporary: false}]
        };
        let reqRes = await execReq(
            "post", 
            `${KEYCLOAK_HOST}admin/realms/${REALM_NAME}/users`,
            userRepr,
            {'Content-Type': 'application/json', Authorization: 'Bearer ' + at }
        );
        if(reqRes.error){
            log("ERROR", reqRes.error);
            continue;
        }

        insertedUsers.set(user.username, password)
        log("DEBUG", `Created user: ${user.username} with password: ${password}`);
    }

    return insertedUsers;
}
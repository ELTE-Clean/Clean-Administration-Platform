import KeycloakConnect from 'keycloak-connect';
import {MemoryStore} from 'express-session';
import * as express from 'express';


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


/* Keycloak and the memory storage objects */
export const memoryStore = new MemoryStore();                       
export const keycloak = new KeycloakConnect({ store: memoryStore }, kc_config);


/* Disable link forwarding since we are using a pure API */
keycloak.redirectToLogin = function(req) { return false; };

/* Extra Utilities */
export const protector: KeycloakConnect.GuardFn = (token, req) => {
    console.log(token.hasRole(`student`));        // Currently we only print. However, in the future, we might need to do more stuff in the protector.
    return true;
}

/**
 * An express middleware to check if the user is authunticated (Has a grant to be more specific).
 * Note that Protect() can also check for authunticated user. 
 *  But we also may need to define our own checking middleware for the future usage.
 * @param req Request object
 * @param res Response object
 * @param next express Next object
 */
export const isAuth: express.RequestHandler = (req: express.Request, res: express.Response, next : express.NextFunction) => {
    keycloak.getGrant(req, res).then((grant) => {
        console.log("[INFO]: User is authunticated.");
        next();
    }).catch( err => {
        console.log("[INFO]: User is not authunticated. Keycloak.Grant can't be found in the session");
        next(err);
    });
}


/**
 * An express middleware to check if the user is NOT authunticated. 
 *  This can be used in cases for an eplicit check. 
 *  When it is a must for the user not to be authunticated.
 * @param req Request object
 * @param res Response object
 * @param next express Next object
 */
 export const isUnauth: express.RequestHandler = (req: express.Request, res: express.Response, next : express.NextFunction) => {
    keycloak.getGrant(req, res).then((grant) => {
        console.log("[INFO]: User is authunticated.");
        let err = new Error("User is already logged in");
        next(err);
    }).catch( err => {
        console.log("[INFO]: User is not authunticated. Keycloak.Grant can't be found in the session");
        next();
    });
}
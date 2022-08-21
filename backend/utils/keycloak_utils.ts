import KeycloakConnect from 'keycloak-connect';
import {Token, Grant} from 'keycloak-connect';
import { MemoryStore } from 'express-session';
import * as express from 'express';
import {log} from './logger_utils';
import { KeycloakClientAPI } from 'mohido-keycloak-client';


/* Environment variables that are passed to the server */
const KEYCLOAK_HOST : string = process.env.KEYCLOAK_HOST || 'http://nginx/auth/';
const CLIENT_ID     : string = process.env.CLIENT_ID     || "cap-app";
const CLIENT_SECRET : string = process.env.CLIENT_SECRET || 'aQX4Vdbe7PhQTPCwRdeOwIdQzbpGkOdw';  
const REALM_NAME    : string = process.env.REALM_NAME    || 'CAP';

/* Global Keycloak Configuration */
export const kc_config = {
    // clientId: CLIENT_ID,
    // credentials: {
    //     secret: CLIENT_SECRET
    // },
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
const keycloakclient = new KeycloakClientAPI.KeycloakClient(keycloak, CLIENT_ID, CLIENT_SECRET);

/* Disable link forwarding since we are using a pure API */
keycloak.redirectToLogin = function(req) { return false; };


// -------------------------- Interfaces (Objects templates)


/**
 * An express middleware to check if the user is authenticated (Has a grant to be more specific).
 * Note that Protect() can also check for authenticated user. 
 *  But we also may need to define our own checking middleware for the future usage.
 * @param req Request object
 * @param res Response object
 * @param next express Next object
 */
export const isAuth: express.RequestHandler = (req: express.Request, res: express.Response, next : express.NextFunction) => {
    const authenticationDisabled : Boolean = (process.env.DISABLE_AUTHENTICATION || '') == 'true';
    if(authenticationDisabled) 
        return next();
    
    keycloak.getGrant(req, res).then((grant) => {
        console.log("[INFO]: User is authenticated.");
        return next();
    }).catch( err => {
        console.log("[INFO]: User is not authenticated. Keycloak.Grant can't be found in the session");
        return next(err);
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
    const authenticationDisabled : Boolean = (process.env.DISABLE_AUTHENTICATION || '') == 'true';
    if(authenticationDisabled) 
        return next();
    
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
 * A helper function for getting an access token of the current client. This is mainly called from this module
 *  only. However, it can be also called for custom purposes (from within the endpoints) to get a client access
 *  token. If it is called from the endpoints, then it is up to the developer to strictly make sure to use this
 *  token as secure as possible. Because the client has full control of keycloak, the developer must be careful,
 *  what to change in the keycloak server. 
 */
export async function createClientAccessToken(): Promise<string|null>{
    /* Get access token for the client (cap-app) so we can request data from keycloak using that client */
    return await keycloakclient.createAccessToken();
};



/**
 * Return a specific user data with the specific given username
 * @param username - The username registered for the user in keycloak
 * @returns - Keycloak user info which contain the keycloak user data. 
 */
 export async function getUserData (username: string) : Promise<KeycloakClientAPI.KeycloakUser> {
    return await keycloakclient.getUser(username);
};



/**
 * A function that extracts the keycloak data stored in the grant. It contains the keycloak ID of the 
 *  logged in user and other extra information...
 * @param req 
 * @param res 
 */
 export async function getSelfData (req: express.Request, res : express.Response) : Promise<KeycloakClientAPI.KeycloakUser> {
    let grant : Grant = await keycloak.getGrant(req, res);
    const at : Token = grant.access_token as Token;
    const rt : Token = grant.refresh_token as Token;

    if(grant.isExpired() || at.isExpired()){ // An extra validation layer.
        throw new Error("User authentication token is expired");
    }

    const userInfo = await keycloak.grantManager.userInfo(at) as any;
    return await getUserData(userInfo.preferred_username);
};



/**
 * 
 * Get all users that are in the realm. Simply, it graps users by the roles. If no role is given, it returns
 *  all the users in keycloak.
 * 
 * @param roles - Roles to filter users upon.
 * @returns an array of keycloak user data.
 */
export async function getAllUsersData(roles? : string[]) : Promise<KeycloakClientAPI.KeycloakUser[]> {
    return await keycloakclient.getUsers(roles);
}



/**
 * You can call this function to get more details regarding the application roles defined in this module as "appRoles"
 * @returns - All roles details (id, name...etc) of the appRoles
 */
 export async function getAllRolesData() : Promise<{id:string, name:string}[]> {
    return keycloakclient.getRoles();
}


/**
 * Update a given user with new roles. Simply, we delete the old roles then assign new roles to the user. 
 * @param username - Username in which the roles must be updated
 * @param roles - Array of new role/s that will be assigned to the user.
 * @returns - True if successfully updated the role
 */
export async function updateUserRole(username: string, roles: string[]) : Promise<boolean> {
    try{
        await keycloakclient.updateUserRoles(username,roles);
        return true;
    }catch(error){
        log("ERROR", error as string);
        return false;
    }
}




/**
 * Create multiple users in keycloak given an array of KCUserData. 
 * Note:
 *  Passwords are generated randomly. 
 * 
 * Returns:
 *  A map containing the usernames and their relative passwords
 * 
 */
export async function createUsers(users: KeycloakClientAPI.KeycloakUser[]) : Promise<Map<string, string>> {
    return await keycloakclient.createUsers(users);
}

/**
 * Deletes a user from keycloak
 * @param username - the username of the user. 
 * @returns - True if user successfully deleted, otherwise, false.
 */
export async function deleteUser(username: string): Promise<Boolean> {
    try{
        await keycloakclient.deleteUser(username);
        return true;
    }catch(error){
        log("ERROR", error as string);
        return false;
    }
}



/**
 * Protector is a middleware for checking if the logged in user has the authorized role or not.
 * 
 * Usage:
 *  middlewares.., protector(["role1","role2"]), middlewares...
 * */
 export function protector(roles : string[]) : express.RequestHandler {
    const f : express.RequestHandler = (req : express.Request, res:express.Response, next:express.NextFunction) => {
        const authorizationDisabled : Boolean = (process.env.DISABLE_AUTHORIZATION || '') == 'true';
        if(authorizationDisabled) 
            return next();
        
        getSelfData(req, res).then(result => {
            let authorized = result?.roles.filter(rl => roles.indexOf(rl) > -1);
            if(authorized && authorized.length > 0){
                return next();
            }else{
                return next("Unauthorized");
            }
        }).catch(error=>{
            return next(error);
        });
    }

    return f; 
}
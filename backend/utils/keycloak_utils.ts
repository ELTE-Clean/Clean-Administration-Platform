import KeycloakConnect from 'keycloak-connect';
import {Token, Grant} from 'keycloak-connect';
import { MemoryStore } from 'express-session';
import * as express from 'express';
import {log} from './logger_utils';
import { execReq } from './http_utils';
import qs from 'qs';


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
    enabled? : boolean,
    email? : string
};

/**
 * Encapsulate the User data result or error.  This object is returned when the getSelfData() is called.
 */
interface KCUserInfoRequest{
    user : KCUserData | null,
    error : any | null
};



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
};



/**
 * Return a specific user data with the specific given username
 * @param username - The username registered for the user in keycloak
 * @returns - Keycloak user info which contain the keycloak user data. 
 */
 export async function getUserData (username: string) : Promise<KCUserInfoRequest> {
    try{
        const at = await createClientAccessToken(); // access token for the client to edit the realm

        /* Get the keycloak ID of the user */
        let reqRes = await execReq(
            "get", 
            `${KEYCLOAK_HOST}admin/realms/${REALM_NAME}/users?username=${username}`,
            undefined,
            {'Content-Type': 'application/json', Authorization: 'Bearer ' + at }
        );
        if(reqRes.error){
            return {error : reqRes.error, user : null} as KCUserInfoRequest;
        };
        const kcid : string = reqRes.result.data[0].id as string;
        const email_verified = reqRes.result.data[0].emailVerified;
        const enabled = reqRes.result.data[0].enabled;

        /* Get user roles */
        reqRes = await execReq(
            "get", 
            `${KEYCLOAK_HOST}admin/realms/${REALM_NAME}/users/${kcid}/role-mappings/realm`,
            undefined,
            {'Content-Type': 'application/json', Authorization: 'Bearer ' + at }
        );
        if(reqRes.error){
            return {error : reqRes.error, user : null} as KCUserInfoRequest;
        }

        /* Returning the data */
        const userData : KCUserData = { 
            keycloak_id: kcid, 
            enabled : enabled,
            username: username, 
            email_verified : email_verified,
            roles : reqRes.result.data.map((rl: any) => rl.name).filter((rl:any) =>  appRoles.indexOf(rl) > -1)
        } as KCUserData;
        return {error : null, user : userData} as KCUserInfoRequest;
    }catch(error){
        return {error : error, user : null} as KCUserInfoRequest;
    }
};



/**
 * A function that extracts the keycloak data stored in the grant. It contains the keycloak ID of the 
 *  logged in user and other extra information...
 * @param req 
 * @param res 
 */
 export async function getSelfData (req: express.Request, res : express.Response) : Promise<KCUserInfoRequest> {
    try{
        let grant : Grant = await keycloak.getGrant(req, res);
        const at : Token = grant.access_token as Token;
        const rt : Token = grant.refresh_token as Token;

        if(grant.isExpired() || at.isExpired()){ // An extra validation layer.
            throw new Error("User authentication token is expired");
        }

        const userInfo = await keycloak.grantManager.userInfo(at) as any;
        return await getUserData(userInfo.preferred_username);

    }catch(error){
        return {error : error, user : null} as KCUserInfoRequest;
    }
};



/**
 * 
 * Get all users that are in the realm. Simply, it graps users by the roles. If no role is given, it returns
 *  all the users in keycloak.
 * 
 * @param roles - Roles to filter users upon.
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
 * Create multiple users in keycloak given an array of KCUserData. 
 * Note:
 *  Passwords are generated randomly. 
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

/**
 * Deletes a user from keycloak
 * @param username - the username of the user. 
 * @returns - True if user successfully deleted, otherwise, false.
 */
export async function deleteUser(username: string): Promise<Boolean> {
    /* Creating client access token */
    var at : string = "";
    try{
        at = await createClientAccessToken();
    }catch(error){
        log("ERROR", error as string);
        return false;
    }

    /* Getting user keycloak id*/
    const userReq : KCUserInfoRequest = await getUserData (username);
    if(userReq.error){
        log("ERROR", "Failed to get user data");
        return false;
    }

    /* Deleting user from Keycloak */
    const reqRes = await execReq(
        "delete", 
        `${KEYCLOAK_HOST}admin/realms/${REALM_NAME}/users/${userReq.user?.keycloak_id}`,
        {},
        {'Content-Type': 'application/json', Authorization: 'Bearer ' + at }
    );
    if(reqRes.error){
        log("ERROR", reqRes.error);
        return false;
    }

    return true;
}


/**
 * You can call this function to get more details regarding the application roles defined in this module as "appRoles"
 * @returns - All roles details (id, name...etc) of the appRoles
 */
export async function getAllRolesData() : Promise<{id:string, name:string}[]> {
    var at : string = "";
    try{
        at = await createClientAccessToken();
    }catch(error){
        log("ERROR", error as string);
        return [];
    }

    let roleRepresentations : any = [];
    for(const role of appRoles){
        let reqRes = await execReq(
            "get", 
            `${KEYCLOAK_HOST}admin/realms/${REALM_NAME}/roles/${role}`,
            undefined,
            {'Content-Type': 'application/json', Authorization: 'Bearer ' + at }
        );
        if(reqRes.error){
            log("ERROR",reqRes.error as string );
            continue;
        }
        roleRepresentations = [...roleRepresentations, reqRes.result.data];
    }
    return roleRepresentations.map((rl:any) => {return {id:rl.id, name:rl.name}});
}


/**
 * Update a given user with new roles. Simply, we delete the old roles then assign new roles to the user. 
 * @param username - Username in which the roles must be updated
 * @param roles - Array of new role/s that will be assigned to the user.
 * @returns - True if successfully updated the role
 */
export async function updateUserRole(username: string, roles: string[]) : Promise<boolean> {
    roles = roles.filter(rl => appRoles.indexOf(rl) > -1);
    if(roles.length === 0){
        log("ERROR", "No available role for assigning it to the user");
        return false;
    }

    /* Get current user data */
    const udata : KCUserInfoRequest = await getUserData(username);
    if(udata.error){
        log("ERROR", udata.error as string);
        return false;
    }

    /* Client access token to edit the data */
    var at : string = "";
    try{
        at = await createClientAccessToken();
    }catch(error){
        log("ERROR", error as string);
        return false;
    }

    /* Get role representations */
    let rolesData = await getAllRolesData();

    /* Deleting all user's roles */
    let reqRes = await execReq(
        "delete", 
        `${KEYCLOAK_HOST}admin/realms/${REALM_NAME}/users/${udata.user?.keycloak_id}/role-mappings/realm`,
        rolesData,
        {'Content-Type': 'application/json', Authorization: 'Bearer ' + at }
    );
    if(reqRes.error){
        log("ERROR",reqRes.error as string );
        return false;
    }

    /* Assign new roles to the user */
    const filtered_roles = rolesData // Filtering the roles (Getting only the roles in the parameter) */
        .filter((rl : any) => roles.indexOf(rl.name) > -1)
        .map((rl:any) => {return {id : rl.id, name:rl.name}});

    reqRes = await execReq(
        "post", 
        `${KEYCLOAK_HOST}admin/realms/${REALM_NAME}/users/${udata.user?.keycloak_id}/role-mappings/realm`,
        filtered_roles,
        {'Content-Type': 'application/json', Authorization: 'Bearer ' + at }
    );
    if(reqRes.error){
        log("ERROR",reqRes.error as string );
        return false;
    }

    return true;
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
            if(result.error)
                return next(result.error as string);
            let authorized = result.user?.roles.filter(rl => roles.indexOf(rl) > -1);
            if(authorized && authorized.length > 0){
                return next();
            }else{
                return next("Unauthorized");
            }
        });
    }

    return f; 
}
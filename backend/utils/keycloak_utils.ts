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
console.log("Script runs:");


/* Disable link forwarding since we are using a pure API */
keycloak.redirectToLogin = function(req) { return false; };


/* Extra Utilities */
export const protector: KeycloakConnect.GuardFn = (token, req) => {
    console.log("DEBUG: protector(tkn, req): ", req);
    console.log("DEBUG: protector(tkn, req): token is defined: ", !(!token));
    return true;
}

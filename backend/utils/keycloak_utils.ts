import KeycloakConnect from 'keycloak-connect';
import {MemoryStore} from 'express-session';


/* Environment variables that are passed to the server */
const KEYCLOAK_HOST = 'http://nginx/auth/';
const CLIENT_ID     = "cap-app";
const CLIENT_SECRET = 'aQX4Vdbe7PhQTPCwRdeOwIdQzbpGkOdw';  
const REALM_NAME    = 'CAP';

/* Global Keycloak Configuration */
// const kc_config = {
//     clientId :      CLIENT_ID,              // Our application (Keycloak Client)
//     bearerOnly:     true,                   // Only accept http/s headers with bearer tokens only
//     serverUrl:      KEYCLOAK_HOST,          // Keycloak URL
//     realm:          REALM_NAME,             // Keycloak's Realm.
//     clientSecret:   CLIENT_SECRET           // The realm key
// }

export const kc_config = {
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

//export = {memoryStore, keycloak, kc_config};
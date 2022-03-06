# Clean-Administration-Platform

## Technologies

## Front-End:
 - Next.JS 
 - React.JS
 - Typescript


## Back-End:
 - Express.js
 - Postgresql
 - Auth: keycloak
 - To test if the Keycloak Authuntication works: 
    * `docker exec -it clean_administration_platform_backend_1 sh`
    * `wget -O - --header 'Content-Type: application/x-www-form-urlencoded' --post-data "username=teacher-1&password=123&client_id=cap-app&client_secret=aQX4Vdbe7PhQTPCwRdeOwIdQzbpGkOdw&grant_type=password" "http://nginx/auth/realms/CAP/protocol/openid-connect/token"`
    * Means: 
    * You will get an access_token + refresh_token. The previous means that the authuntication was valid as a teacher. You can access the application freely.


Env: Docker K8S
Automation: Python

To view the full debug logs add the following lines to the keycloak .env file.
* KEYCLOAK_LOGLEVEL=DEBUG
* ROOT_LOGLEVEL=DEBUG
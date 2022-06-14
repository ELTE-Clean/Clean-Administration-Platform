# Keycloak Component

The authentication process happens within the *Keycloak* server. It may only be accessed by maintainers, and intranet (inner network) users. Maintainers may change the credentials and manage the roles of the users if manual assessement is needed.

---

To test if the Keycloak Authentication works:
* `docker exec -it clean_administration_platform_backend_1 sh`
* `wget -O - --header 'Content-Type: application/x-www-form-urlencoded' --post-data "username=teacher-1&password=123&client_id=cap-app&client_secret=aQX4Vdbe7PhQTPCwRdeOwIdQzbpGkOdw&grant_type=password" "http://nginx/auth/realms/CAP/protocol/openid-connect/token"`

Means:
* You will get an access_token + refresh_token. The previous means that the authentication was valid as a teacher. You can access the application freely.

To view the full debug logs add the following lines to the keycloak.env file.
* KEYCLOAK_LOGLEVEL=DEBUG
* ROOT_LOGLEVEL=DEBUG
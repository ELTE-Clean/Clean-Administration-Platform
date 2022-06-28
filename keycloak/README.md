# Keycloak Component
*Keycloak* is a free authentication server. It stores the users, their credentials, and their roles. It may only be accessed by maintainers, and intranet (inner network) components through either the keycloak api or the UI. Maintainers may change the credentials and manage the roles of the users if manual assessement is needed. Keycloak is a complicated component by its own and has lots of configurations that can be tweaked. However, the project only uses the very basic features to authenticate through it. 


Whenever a login request is sent to keycloak, two tokens are returned defining the user. Once these tokens are received, it means that the user logged in successfully to the interface.


## Notes: 
To view the full debug logs add the following lines to the `keycloak.env` file.
* KEYCLOAK_LOGLEVEL=DEBUG
* ROOT_LOGLEVEL=DEBUG

/* Dependencies Importing */
const router = require('express-promise-router')();     // Used to handle async request. Will be useful in the future to dodge the pyramid of doom
const keycloak = require('../utils/keycloak_utils').keycloak;
const protector = require('../utils/keycloak_utils').protector;


/* Getters Area. */
router.get("/", (req, res, next) => {
    console.log(req);
    res.status(200).send(JSON.stringify({message: res}));
});

router.get("/protect", keycloak.protect(protector), (req, res, next) => {
    res.status(200).send(JSON.stringify({response: "Server is responding to the root url."}));
});

router.get('/logout', keycloak.protect(), (req, res, next)=>{
    console.log("Starting a loggingout section.");
    res.status(200).send(JSON.stringify({response: "logging out"}))
});

router.get('/role', keycloak.protect('student'), (req, res, next)=>{
    console.log("Starting a student section.");
    res.status(200).send(JSON.stringify({response: "student out"}))
});


router.get('/gettoken', (req, res, next)=>{
    console.log("Getting token using the grant manager");
    console.log(keycloak.getConfig());
    keycloak.grantManager.obtainDirectly('student-1', '123').then(
        (grant) => {
            let access_token = grant.access_token.token;
            let refresh_token = grant.refresh_token.token;
            console.log("Access Token: ", access_token);
            console.log(grant);
            keycloak.storeGrant(grant, req, res);
            console.log("stored grant")
        }
    ).catch((error) => {console.log(error)});
    res.status(200).send(JSON.stringify({response: "token gotten"}))
});

module.exports = router;
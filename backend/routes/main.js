/* Dependencies Importing */
const router = require('express-promise-router')();     // Used to handle async request. Will be useful in the future to dodge the pyramid of doom
const keycloak = require('../utils/keycloak_utils').keycloak;

/* Getters Area. */
router.get("/", (req, res, next) => {
    res.status(200).send(JSON.stringify({response: "Server is responding to the root url."}));
});

/* Getters Area. */
router.get("/protect", keycloak.protect(), (req, res, next) => {
    res.status(200).send(JSON.stringify({response: "Server is responding to the root url."}));
});


module.exports = router;
/* Dependencies Importing */
const router = require('express-promise-router')();     // Used to handle async request. Will be useful in the future to dodge the pyramid of doom
const keycloak = require('../utils/keycloak_utils').keycloak;
const protector = require('../utils/keycloak_utils').protector;
const isAuth = require('../utils/keycloak_utils').isAuth;
const isUnauth = require('../utils/keycloak_utils').isUnauth;
const log = require('../utils/logger_utils').log;



/* Importing Routers */
router.use('/users', require('./users'));
router.use('/groups', require('./groups'));
router.use('/sections', require('./sections'));
router.use('/tasks', require('./tasks'));


/**
 * A production-level /login endpoint. 
 */
router.post("/login", isUnauth, (req, res, next) => {
    let username = req.body.username;
    let password = req.body.password;
    log("DEBUG", `/login: User details: ${username} , ${password}`);
    
    // Log-in using the keycloak grantManager object.
    keycloak.grantManager.obtainDirectly(username, password)
    .then((grant) => {
            keycloak.storeGrant(grant, req, res);   // we store the grant (Tokens and stuff) in the req.session as 'keycloak-token'
            res.status(200).send(JSON.stringify({response: `user ${username} is logged in successfully.`}))
    })
    .catch((error) => {console.log(error); return next(error)});
});


/**
 * This will logout the user, destroy the session data that correspond to that user. Note that, it won't 
 * delete the session, but it will only destroy the keycloak data attached to that session.
 * So other arbitrary data can still be saved in the session.
 * 
 */
router.post("/logout", isAuth, (req, res, next) => {
    let sid = req.session.id;
    keycloak.unstoreGrant(sid);     // destroys the keycloak data corresponding to this session.
    res.status(200).send(JSON.stringify({message: "User is Logged out and session has been destroyed"}));
});



module.exports = router;
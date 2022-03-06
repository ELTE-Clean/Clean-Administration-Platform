/* Dependencies Importing */
const router = require('express-promise-router')();     // Used to handle async request. Will be useful in the future to dodge the pyramid of doom
const keycloak = require('../utils/keycloak_utils').keycloak;
const protector = require('../utils/keycloak_utils').protector;
const isAuth = require('../utils/keycloak_utils').isAuth;
const isUnauth = require('../utils/keycloak_utils').isUnauth;


/* LOG-IN Endpoints */
/**
 * A simple login endpoint to check if everything is working perfectly. In real applications we will not need this one.
 */
router.get("/login", isUnauth, (req, res, next) => {
    keycloak.grantManager.obtainDirectly('student-1', '123').then(
        (grant) => {
            keycloak.storeGrant(grant, req, res);
            res.status(200).send(JSON.stringify({response: `user \"student-1\" is logged in.`}))
        }
    ).catch((error) => {console.log(error); return next(error)});
});


/**
 * A production-level /login endpoint. 
 */
router.post("/login", isUnauth, (req, res, next) => {
    let username = req.body.username;
    let password = req.body.password;

    // Log-in using the keycloak grantManager object.
    keycloak.grantManager.obtainDirectly(username, password)
    .then((grant) => {
            keycloak.storeGrant(grant, req, res);   // we store the grant (Tokens and stuff) in the req.session as 'keycloak-token'
            res.status(200).send(JSON.stringify({response: `user ${username} is logged in successfully.`}))
    })
    .catch((error) => {console.log(error); return next(error)});
});


/* MAIN endpoint route */
/**
 * This route is for testing if the user is authunticated or not. Only authunticated user can access
 *  this route. 
 * * keycloak.protect(function()) : This will check if user is authunticated and use a simple 
 *      protector (Costum made) function to check if the user is authurized or not.
 * * isAuth : is another costum middleware that we defined. It just check if there is a 
 *      keycloak.grant somewhere in the session.
 */
router.get("/main", keycloak.protect(protector), isAuth, (req, res, next) => {
    // console.log("Main getter started")
    // console.log("SID: ", req.session.id);
    keycloak.getGrant(req, res).then((grant) => {
        // console.log("The current grant set to this session is: ", grant);
        // console.log("User is loged in already. The cookie is still active.");
        res.status(200).send(JSON.stringify({message: "User is logged in and authenticated!"}));
    }).catch( err => {
        console.log(err);
        return next("User must be authunticated to access this page.");
    });
});


/**
 * This will logout the user, destroy the session data that correspond to that user. Note that, it won't 
 *  delete the session, but it will only destroy the keycloak data attached to that session. 
 *  So other arbitrary data can still be saved in the session. 
 * 
 */
router.get("/logout", isAuth, (req, res, next) => {
    let sid = req.session.id;
    console.log("SID : ", sid);
    keycloak.unstoreGrant(sid);     // destroys the keycloak data corresponding to this session.
    res.status(200).send(JSON.stringify({message: "User is Logged out and session has been destroyed"}));
});

module.exports = router;

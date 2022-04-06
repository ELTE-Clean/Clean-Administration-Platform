/** Handles the users functionalities /users/.... */

/* Dependencies Importing */
const router = require('express-promise-router')();     // Used to handle async request. Will be useful in the future to dodge the pyramid of doom
const keycloak = require('../utils/keycloak_utils').keycloak;
const isAuth = require('../utils/keycloak_utils').isAuth;
const isUnauth = require('../utils/keycloak_utils').isUnauth;
const {execTrans, startTrans, execQuery, endTrans} = require('../utils/database_utils');
const log = require('../utils/logger_utils').log;
const execReq = require('../utils/http_utils').execReq;

/* Getters */
router.get('/get/profile', keycloak.protect, async (req, res, next) => {
    keycloak.getGrant(req, res).then((grant) => {
        const at = grant.access_token;
        const rt = grant.refresh_token;
        
        keycloak.grantManager.userInfo(at)
         .then((user) => {console.log(user)})
         .catch((err) => {log("ERROR", "Grant Manager Can't identify the given token."); return next(err);});

        // Get user details from keycloak.
        //let reqRes = await execReq("GET", "     " ,  );

        // Get user profile from the database.
       // const qry = { text: "SELECT * FROM `users` WHERE " };
        //execQuery(qry)
        //.then((result) => res.status(200).send(JSON.stringify({message: result.result.rows})))
        //.catch((error) => {console.log(error); return next(error)});
        res.status(200).send(JSON.stringify({message: "User is logged in and authenticated!"}));
    }).catch( err => {
        console.log(err);
        return next("User must be authenticated to access this page.");
    });
});


module.exports = router;


/** Handles the users functionalities /users/.... */

/* Dependencies Importing */
const router = require('express-promise-router')();     // Used to handle async request. Will be useful in the future to dodge the pyramid of doom
const keycloak = require('../utils/keycloak_utils').keycloak;
const {isAuth, getUserData, isUnauth} = require('../utils/keycloak_utils');
const {execTrans, startTrans, execQuery, endTrans} = require('../utils/database_utils');
const log = require('../utils/logger_utils').log;
const execReq = require('../utils/http_utils').execReq;




/* Getters */
router.get('/get/profile', async (req, res, next) => {
    log("INFO", `Getting user profile.`);
    const userReqKC = await getUserData(req, res);
    console.log(userReqKC);
    if(userReqKC.error){
        log("ERROR", `Error in getting the user data from the access token`);
        return next(userReqKC.error);
    }

    let qry = {text: `SELECT * FROM users WHERE username = $1;`, values : [userReqKC.user.username]};
    const userReqDB = await execQuery(qry);
    console.log(userReqDB);
    if(userReqDB.error){
        log("ERROR", `Error in requesting the user from the databae`);
        return next(userReqKC.error);
    }else if(userReqDB.result.rowCount == 0){
        log("ERROR", `User Not found`);
        return next("No such user exists in the Database. It exists only in our keycloak server.");
    }

    const retUser = {
        kcid : userReqKC.user.keycloak_id, 
        username: userReqKC.user.username, 
        firstname: userReqDB.result.rows[0].firstname,
        lastname: userReqDB.result.rows[0].lastname,
        uid : userReqDB.result.rows[0].id
    };

    console.log(retUser);
    return res.status(200).send(retUser);
});


module.exports = router;


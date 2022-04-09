/** Handles the users functionalities /users/.... */

/* Dependencies Importing */
const router = require('express-promise-router')();     // Used to handle async request. Will be useful in the future to dodge the pyramid of doom
const keycloak = require('../utils/keycloak_utils').keycloak;
const {isAuth, getUserData, isUnauth, getAllUsersData} = require('../utils/keycloak_utils');
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
    if(userReqDB.error){
        log("ERROR", `Error in requesting the user from the databae`);
        return next(userReqKC.error);
    }else if(userReqDB.result.rowCount == 0){
        log("ERROR", `User Not found`);
        return next("No such user exists in the Database. It exists only in our keycloak server.");
    }

    const retUser = {
        uid : userReqDB.result.rows[0].id,
        kcid : userReqKC.user.keycloak_id, 
        username: userReqKC.user.username, 
        firstname: userReqDB.result.rows[0].firstname.replace(/[ \t]+$/g, ''),
        lastname: userReqDB.result.rows[0].lastname.replace(/[ \t]+$/g, ''),
        roles : userReqKC.user.roles,
    };

    log("INFO", `[users/get/profile]: "${retUser.username}" Profile Requested`);
    return res.status(200).send(retUser);
});



/**
 * Get all users data from both the keycloak and database. Note that if a user exist in keycloak
 *  and not in the database, will return only the junction between the two databases. Therefore,
 *  users that exists in both databases are the ones that are returned.
 */
router.get('/get/all', async(req, res) => {
    log("INFO", "All users data have been requested");
    const usersKC_arr = await getAllUsersData();

    /* Transform the array to a map (username => keycloak user data) */
    const usersKC_map = new Map();
    usersKC_arr.forEach(userKC => {
        if(!usersKC_map.has(userKC.username))
            usersKC_map.set(userKC.username,userKC); 
        else{
            const ukc = usersKC_map.get(userKC.username); // .roles + userKC.roles;
            ukc.roles += userKC.roles;
            usersKC_map.set(userKC.username, ukc);
        }
    });

    /* Get all users from the database */
    const userReqDB = await execQuery({text: `SELECT * FROM users`});
    if(userReqDB.error){
        log("ERROR", `Error in requesting the user from the databae`);
        return next(userReqKC.error);
    }

    /* Return the users that correspond to a keycloak username only */
    let ret = [];
    for(const userDB of userReqDB.result.rows){
        const username = userDB.username.replace(/\s/g, ''); // Since our usernames in the database have white spaces in the end, we remove them :) 
        if(!usersKC_map.has(username))
            continue;
        const kcuser = usersKC_map.get(username);
        ret = [...ret, 
            {
                uid : userDB.id,
                kcid : kcuser.keycloak_id, 
                username: kcuser.username, 
                firstname: userDB.firstname.replace(/[ \t]+$/g, ''),    // Until we remove whitespaces from database
                lastname: userDB.lastname.replace(/[ \t]+$/g, ''),      // Until we remove whitespaces from database
                roles : kcuser.roles,
            }
        ];
    }

    log("INFO", "All users data have been returned successfully");
    res.status(200).send(ret);
});




module.exports = router;
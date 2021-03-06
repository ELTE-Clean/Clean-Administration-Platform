/* Handles users functionalities /users/.... */

/* Dependencies Importing */
const router = require('express-promise-router')();     // Used to handle async request. Will be useful in the future to dodge the pyramid of doom
const keycloak = require('../utils/keycloak_utils').keycloak;
const { isAuth, getSelfData, isUnauth, getAllUsersData, createUsers, protector, updateUserRole, deleteUser } = require('../utils/keycloak_utils');
const { selectFromTable, insertIntoTable, deleteFromTable, execQuery } = require('../utils/database_utils');
const log = require('../utils/logger_utils').log;



/* Getters */
router.get('/self', isAuth, async (req, res, next) => {
    log("INFO", `Getting user profile.`);
    const userReqKC = await getSelfData(req, res);
    if(userReqKC.error){
        log("ERROR", `Error in getting the user data from the access token`);
        return next(userReqKC.error);
    }

    let userReqDB = await selectFromTable('users', {username : userReqKC.user.username})
    if(userReqDB.error){
        log("ERROR", `Error in requesting the user from the database`);
        return next(userReqDB.error);
    }else if(userReqDB.result.rowCount == 0){
        log("ERROR", `User Not found`);
        return next("No such user exists in the Database. It exists only in our keycloak server.");
    }

    const grpReqDB = await selectFromTable('user_to_group', {userID : userReqDB.result.rows[0].userid})
    if(grpReqDB.error){
        log("ERROR", `Error in requesting the user's groups from the database`);
        return next(grpReqDB.error);
    }

    const mapIDs = grpReqDB.result?.rows.map(grp => grp.groupid);
    const retUser = {
        uid : userReqDB.result.rows[0].userid,
        neptun : userReqDB.result.rows[0].neptun,
        groupIDs : mapIDs,
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
 *
 * Note:
 *  Only admins or demonstrators have the ability to get all the users.
 */
router.get('/', isAuth, protector(["admin", "demonstrator"]), async(req, res) => {
    log("INFO", "All users data have been requested");
    const usersKC_arr = await getAllUsersData();

    /* Transform the array to a map (username => keycloak user data) */
    const usersKC_map = new Map();
    usersKC_arr.forEach((userKC) => {
        if (!usersKC_map.has(userKC.username))
            usersKC_map.set(userKC.username, userKC);
        else {
            const ukc = usersKC_map.get(userKC.username); // .roles + userKC.roles;
            ukc.roles += userKC.roles;
            usersKC_map.set(userKC.username, ukc);
        }
    });

    /* Get all users from the database */
    const userReqDB = await execQuery({ text: `SELECT * FROM users` });
    if (userReqDB.error) {
        log("ERROR", `Error in requesting the user from the databae`);
        return next(userReqKC.error);
    }

    /* Return the users that correspond to a keycloak username only */
    let ret = [];
    for (const userDB of userReqDB.result.rows) {
        const username = userDB.username.replace(/\s/g, ""); // Since our usernames in the database have white spaces in the end, we remove them :)
        if (!usersKC_map.has(username)) 
            continue;

        const grpReqDB = await selectFromTable('user_to_group', {userID : userDB.userid})
        if(grpReqDB.error){
            log("ERROR", `Error in requesting the user's groups from the database`);
            return next(grpReqDB.error);
        }
        

        const mapIDs = grpReqDB.result?.rows.map(grp => grp.groupid);
        const kcuser = usersKC_map.get(username);
        ret = [ ...ret,{
            uid: userDB.userid,
            groupIDs : mapIDs,
            neptun: userDB.neptun,
            kcid: kcuser.keycloak_id,
            username: kcuser.username,
            firstname: userDB.firstname.replace(/[ \t]+$/g, ""), // Until we remove whitespaces from database
            lastname: userDB.lastname.replace(/[ \t]+$/g, ""), // Until we remove whitespaces from database
            roles: kcuser.roles,
            }];
    }

    log("INFO", "All users data have been returned successfully");
    res.status(200).send(ret);
});



/**
 * 
 * Takes a list of users and creates them in both the keycloak and database with random passwords.
 * Pre-conditions:
 *  Request Body Contains: body{ 
 *                           users: [
 *                              {username: char[20], // unique username (maps database to keycloak) (can be neptun code)
 *                               firstname:char[20], // firstname
 *                               lastname:char[20],  // lastname
 *                               uid: char[6]},
 *                               roles: string[]
 *                           ]      // unique id (can be neptun code.)
 *                        }
 * Returns:
 *  [{username, password}]
 *
 */
router.post('/create', isAuth, protector(["admin"]), async (req, res, next) =>{
    if(!req.body.users)
        return next("'users' is not defined in the request body");

    /* Create users in keycloak */
    const users_kc = req.body.users.map(user => {
        return {
            // keycloak_id: "",
            username: user.username,
            email_verified : user.email_verified || false,
            roles : user.roles,
            email : user.email  || ""
        };
    });
    var insertedUsersKC = [];
    const temp = await createUsers(users_kc);
    temp.forEach((value, key) => {
        insertedUsersKC = [...insertedUsersKC, {"username": `${key}`, "password": `${value}`}];
    });
    if(insertedUsersKC.length === 0){
        return next("could not create users");
    }

    /* Create users in the database. */
    for (const user of req.body.users) {
        const student = {
            neptun: user.neptun || user.username,
            username: user.username, 
            firstname : user.firstname || "", 
            lastname : user.lastname || ""
        };
        const result = await insertIntoTable('users', student);
        if (result.error){
            log("ERROR", `Can't create user: ${user.username} in the database`);
            return next("User Creation Failed");
        } 
    }

    return res.status(200).send(insertedUsersKC);
});



/**
 * Update user's role. Only admins have the ability to change users roles.
 * Preconditions:
 *  Request Body Contains: username: string, roles : string[]
 *  Logged in user must have an admin role.
 *
 * Returns:
 *  status: 201
 *  object: {message}
 */
router.put("/update/role", isAuth, protector(["admin"]), async (req, res, next) => {
    if (!req.body.roles || !req.body.username || req.body.roles.length === 0)
        return next("'role' is not defined in the request body");

    log("INFO", `Assigning ${req.body.username} the following roles: ${req.body.roles.toString()}`);
    const updated = await updateUserRole(req.body.username, req.body.roles);
    if (!updated) return next("Role of the user did not update");

    log("INFO", `Roles assigned successfully`);
    return res.status(201).send({ message: "Role updates successfully" });
  }
);


/**
 * Takes a list of users and deletes them in both the keycloak and database with random passwords.
 * Request Body Contains: users: [{userid}]
 */
router.delete('/', isAuth, protector(["admin"]), async (req, res, next) =>{
    if(!req.body.users)
        return next("'users' is not defined in the request body");

    /* Delete users in the database. */
    for (const user of req.body.users) {
        if(!user.username){
            log("ERROR", `username must be supplied in the delete request`);
            return next("User Deletion Failed");
        }
        const param = {username: user.username}

        /* Get user data from database */
        let result = await selectFromTable('users', param);
        if (result.error){
          log("ERROR", `Can't retrieve userid: ${param.username} from the database`);
          return next("User Query Failed");
        }
        
        /* Delete user from keycloak */
        const username = result.result.rows[0].username;
        const userid = result.result.rows[0].userid;
        if(!(await deleteUser(username)))
            continue;

        /* Delete the user data from database */
        result = await deleteFromTable('user_to_group', {userid: userid});
        if (result.error){
            log("ERROR", `Can't delete userid: ${userid} from their groups in the database`);
            return next("User Deletion Failed");
        }

        result = await deleteFromTable('grades', {userid: userid});
        if (result.error){
            log("ERROR", `Can't delete userid: ${userid}'s grades in the database`);
            return next("User Deletion Failed");
        } 

        result = await deleteFromTable('users', {userid: userid});
        if (result.error){
            log("ERROR", `Can't delete userid: ${userid} in the database`);
            return next("User Deletion Failed");
        }
    }

    return res.status(200).send(JSON.stringify({message: "Users successfully deleted from the database"}));
});

/// TODO: User password update.

module.exports = router;
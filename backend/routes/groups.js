/* Handles database functionalities /db/.... */

/* Dependencies Importing */
const router = require('express-promise-router')();     // Used to handle async request. Will be useful in the future to dodge the pyramid of doom
const { selectFromTable, insertIntoTable, deleteFromTable, updateTable } = require('../utils/database_utils');
const { isAuth, protector, keycloak , getSelfData} = require('../utils/keycloak_utils');


/**
 * Get groups
 */
router.get("/", isAuth, protector(["admin", "demonstrator"]), async (req, res, next) => {
    if(!process.env.DISABLE_AUTHENTICATION && !process.env.DISABLE_AUTHORIZATION){
        const userData = await getSelfData(req,res);
        if(userData.user.roles.indexOf("demonstrator") >= 0){
            /* Get user id from database */
            let result = await selectFromTable("users", {username : userData.user.username});
            if(result.error)
                return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
            const uid = result.result.rows[0].userID;

            /* Get demonstrator assigned groups */
            result = await selectFromTable("user_to_group", {userID: uid});
            if(result.error)
                return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
            
            /* Get group names and details */
            const groupIDs = result.result.rows.map(row => {groupID: row.groupID});
            result = await selectFromTable("groups", groupIDs);
            if(result.error)
                return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
            
            return res.status(200).send(JSON.stringify({message: "Successfull request", results : result.result.rows}));
        }
    }

    const result = await selectFromTable("groups", {});
    if(result.error)
        return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    
    return res.status(200).send(JSON.stringify({message:"Successfull request", results:result.result.rows}));
});


/**
 * Creates a new group
 * req.body: {groupname, timetable?}
 */
 router.post("/create", isAuth, protector(["admin", "demonstrator"]), async (req, res, next) => {
    const result = await insertIntoTable('groups', req.body);
    if (result.error) 
        return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    return res.status(200).send(JSON.stringify({message: "Group successfully created"}));
});

/**
 * Assign a user to a group. Only admins can do this...
 */
 router.put("/assign", isAuth, protector(["admin"]), async (req, res, next) => {
    const result = await insertIntoTable('user_to_group', req.body);
    if (result.error) 
        return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    return res.status(200).send(JSON.stringify({message: "User successfully assigned to group"}));
});

/**
 * Unassign a user from group. Only admins can do this...
 */
router.delete("/unassign", isAuth, protector(["admin"]), async (req, res, next) => {
    const result = await deleteFromTable('user_to_group', req.body);
    if (result.error) 
        return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    return res.status(200).send(JSON.stringify({message: "User successfully unassigned from group"}));
});




module.exports = router;
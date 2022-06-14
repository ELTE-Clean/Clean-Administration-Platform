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
        
        /* Get only groups that are assigned to the demonstrator */
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
 * Creates a new group .. Only admins can create new groups
 * req.body: {groupname, timetable?}
 */
 router.post("/create", isAuth, protector(["admin"]), async (req, res, next) => {
    const result = await insertIntoTable('groups', req.body);
    if (result.error) 
        return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    return res.status(200).send(JSON.stringify({message: "Group successfully created"}));
});



/**
 * Assign a user to a group. Only admins can do this...
 * 
 * The endpoint deduce the user by its userID, if userID is not found in the request, then its neptun is prioritized.
 * Therefore, provide either the userID or the Neptun. Same logic goes to the groups
 * req.body: {
 *  userID : <Integer>,
 *  neptun: <Text>,
 *  groupID : <Integer>,
 *  groupName : <Text> 
 * }
 */
 router.put("/assign", isAuth, protector(["admin"]), async (req, res, next) => {
    if(req.body.userID && req.body.groupID){
        const result = await insertIntoTable('user_to_group', {userID: req.body.userID, groupID: req.body.groupID});
        if (result.error) 
            return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
        return res.status(200).send(JSON.stringify({message: "User successfully assigned to group"}));
    }

    /* If userID not found, get its id from querying the database... */
    let uid = req.body.userID;
    if(!req.body.userID && req.body.neptun){
        const result = await selectFromTable('users', {neptun: req.body.neptun});
        if (result.error) 
            return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
        if (result.result.rows.length == 0)
            return res.status(404).send(JSON.stringify({message: "User is not Found!"}));
        uid = result.result.rows[0].userid;
    }

    /* Get Group ID if groupName exists */
    let gid = req.body.groupID;
    if(!req.body.groupID && req.body.groupName){
        const result = await selectFromTable('groups', {groupname: req.body.groupName});
        if (result.error) 
            return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
        if (result.result.rows.length == 0)
            return res.status(404).send(JSON.stringify({message: "Group is not Found!"}));
        gid = result.result.rows[0].groupid;
    }

    /* Assign users to group. */
    if(gid && uid){
        const result = await insertIntoTable('user_to_group', {userID: uid, groupID: gid});
        if (result.error) 
            return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
        return res.status(200).send(JSON.stringify({message: "User successfully assigned to group"}));
    }
    return next("Error in assigning user to group");
    
});



/**
 * Unassign a user from group. Only admins can do this...
 * 
 * Works with the same logic as the assign users to group. Please insert the userID or neptun and the group 
 * to unassign from
 */
router.delete("/unassign", isAuth, protector(["admin"]), async (req, res, next) => {
    if(req.body.userID && req.body.groupID){
        const result = await deleteFromTable('user_to_group', {userID: req.body.userID, groupID: req.body.groupID});
        if (result.error) 
            return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
        return res.status(200).send(JSON.stringify({message: "User successfully assigned to group"}));
    }

    /* If userID not found, get its id from querying the database... */
    let uid = req.body.userID;
    if(!req.body.userID && req.body.neptun){
        const result = await selectFromTable('users', {neptun: req.body.neptun});
        if (result.error) 
            return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
        if (result.result.rows.length == 0)
            return res.status(404).send(JSON.stringify({message: "User is not Found!"}));
        uid = result.result.rows[0].userid;
    }

    /* Get Group ID if groupName exists */
    let gid = req.body.groupID;
    if(!req.body.groupID && req.body.groupName){
        const result = await selectFromTable('groups', {groupname: req.body.groupName});
        if (result.error) 
            return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
        if (result.result.rows.length == 0)
            return res.status(404).send(JSON.stringify({message: "Group is not Found!"}));
        gid = result.result.rows[0].groupid;
    }

    /* Assign users to group. */
    if(gid && uid){
        const result = await deleteFromTable('user_to_group', {userID: uid, groupID: gid});
        if (result.error) 
            return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
        return res.status(200).send(JSON.stringify({message: "User successfully unassigned to group"}));
    }
    return next("Error in unassigning user to group");

});

/**
 * Delete a group. Only admins can do this...
 * req.body: {groupid | groupName}
 */
 router.delete("/", isAuth, protector(["admin"]), async (req, res, next) => {
    const groupID = req.body.groupid || req.body.groupID;
    const groupName = req.body.groupname || req.body.groupName;
    if(!groupID && !groupName)
        return res.status(404).send(JSON.stringify({message: "Missing input values!"}));

    let parameters = {};
    if(groupName){
        parameters.groupName = groupName;
    }
    if(groupID){
        parameters.groupID = groupID;
    }

    /* Get gropu data */
    const group = await selectFromTable('groups', parameters);
    if (group.error) next("Could not get group");
    if (group.result.rowCount === 0)
        return next("Group does not exist");

    /* Delete users assigned to group */
    const unassignStudentsResult = await deleteFromTable('user_to_group', { groupid: group.result.rows[0].groupid });
    if (unassignStudentsResult.error) 
        return next("Could not unnasign students from group");

    /* Get sections related to the group */
    const sections = await selectFromTable("sections", { groupid: group.result.rows[0].groupid });
    if (sections.error) 
        return next("Could not get sections associated with group");

    /* Delete each section data */
    sections.result.rows.forEach(async (section) =>{
        /* Tasks related to sections */
        const tasksToRemove = await selectFromTable("tasks", { sectionid: section.sectionid });
        if (tasksToRemove.error)
            return next("Could not get tasks associated with section");

        /* Remove grades in the task */
        tasksToRemove.result.rows.forEach(async (task) => {
          const result = await deleteFromTable("grades", { taskid: task.taskid });
          if (result.error)
            return next("Could not delete task submission (grade) associated with section");
        });

        const taskDelResult = await deleteFromTable("tasks", { sectionid: section.sectionid });
        if (taskDelResult.error)
            return next("Could not delete tasks associated with section");
    })

    /* Delete sections after their data are deleted */
    const sectionDelResult = await deleteFromTable("sections", { groupid: group.result.rows[0].groupid });
    if (sectionDelResult.error) 
        return next("Could not delete sections associated with group");

    const result = await deleteFromTable('groups', parameters);
    if (result.error)
        return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    return res.status(200).send(JSON.stringify({message: "Group has been deleted successfully"}));
});


module.exports = router;
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
    const unassignStudentsResult = await deleteFromTable('user_to_group', parameters);
    if (unassignStudentsResult.error) 
        return next("Could not unnasign students from group");

    /* Get sections related to the group */
    const sections = await selectFromTable("sections", {groupID: groupID});
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

        const taskDelResult = await deleteFromTable("tasks", req.body);
        if (taskDelResult.error)
            return next("Could not delete task associated with section");

        /* Delete the section after its data are deleted */
        const sectionDelResult = await deleteFromTable("sections", req.body);
        if (sectionDelResult.error) 
            return next("Could not delete section");
    })

    const result = await deleteFromTable('groups', parameters);
    if (result.error)
        return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    return res.status(200).send(JSON.stringify({message: "Group has been deleted successfully"}));
});


module.exports = router;
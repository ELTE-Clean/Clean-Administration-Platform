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
 * req.body: {groupid}
 */
 router.delete("/", isAuth, protector(["admin"]), async (req, res, next) => {
    const group = await selectFromTable('groups', req.body);
    if (group.error) next("Could not get group");
    if (group.result.rowCount === 0) next("Group does not exist");

    const unassignStudentsResult = await deleteFromTable('user_to_group', req.body);
    if (unassignStudentsResult.error) next("Could not unnasign students from group");

    const sections = await selectFromTable("sections", req.body);
    if (sections.error) next("Could not get sections associated with group");

    sections.result.rows.forEach(async (section) =>{
        const tasksToRemove = await selectFromTable("tasks", { sectionid: section.sectionid });
        if (tasksToRemove.error)
          next("Could not get tasks associated with section");

        tasksToRemove.result.rows.forEach(async (task) => {
          const result = await deleteFromTable("grades", { taskid: task.taskid });
          if (result.error)
            next("Could not delete task submission (grade) associated with section");
        });

        const taskDelResult = await deleteFromTable("tasks", req.body);
        if (taskDelResult.error)
          next("Could not delete task associated with section");

        const sectionDelResult = await deleteFromTable("sections", req.body);
        if (sectionDelResult.error) next("Could not delete section");
    })

    const result = await deleteFromTable('groups', req.body);
    if (result.error)
        return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    return res.status(200).send(JSON.stringify({message: "Group has been deleted successfully"}));
});


module.exports = router;
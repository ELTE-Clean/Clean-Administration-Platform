/* Handles database functionalities /db/.... */

/* Dependencies Importing */
const router = require('express-promise-router')();     // Used to handle async request. Will be useful in the future to dodge the pyramid of doom
const { selectFromTable, insertIntoTable, deleteFromTable, updateTable } = require('../utils/database_utils');
const { isAuth, protector } = require('../utils/keycloak_utils');
const fileUpload = require('express-fileupload');   // Used to parse the incoming formpost files and insert them into req.files


/**
 * Get all tasks. The given query defines the behavior of the endpoint.
 * For instance, if sectionid is given, then we get the section id part..
 * By default, we don't send the description, maxgrade, nor the solution. To request these, 
 * enable them in the query by:
 *  solution=true
 *  description=true
 */
 router.get("/", isAuth, async (req, res, next) => {
    const descriptionEnable = req.query.description == 'true';
    const solutionEnable = req.query.solution == 'true';

    /* Construction of the query parameters */
    let parameters = {};
    if(req.query.sectionid)
        parameters.sectionID = req.query.sectionid;
    if(req.query.groupid)
        parameters.groupID = req.query.groupid;
    if(req.query.taskid)
        parameters.taskID = req.query.taskid;

    /* Get task/s */
    const result = await selectFromTable('tasks', parameters);
    if (result.error) 
        return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));

    /* Decide what to return */
    const filtered = result.result.rows.map(task => {
        let finalShape = {
            taskid: task.taskID,
            taskname: task.taskname,
            sectionid: task.sectionID,
            groupid : task.groupID,
            max : task.max
        };

        if(solutionEnable)
            finalShape.solution = task.solution;
        if(descriptionEnable)
            finalShape.description = task.description;
        return finalShape;
    });

    return res.status(200).send(JSON.stringify(filtered));
});



/**
 * Creates a task.
 * The request must hold two files:
 *  - solution   // The one containing the answers (For the grading script)
 *  - description   // File containing the description of the task
 * 
 * The solution and description can be given through the req.body, or passed by a multipart/form_data protocol.
 * 
 */
router.post('/create', fileUpload({createParentPath: true}), isAuth, protector(['admin', 'demonstrator']),  async (req, res, next) => {
    /* Check if the the incoming data are complete */
    const solExists = (req.files && req.files.solution) || (req.body  && req.body.solution);
    const descExists = (req.files && req.files.description) || (req.body  && req.body.description);
    const incompleteFile = !solExists && !descExists;
    const incompleteBody = !req.body || !req.body.taskid || !req.body.sectionid || !req.body.groupid;
    // if(incompleteFile || incompleteBody)
    //     return res.status(400).send({message: "Description or Solution are missing!"});

    const params = req.body;

    if (solExists) {
        const sol = req.files.solution.data.toString("utf8") || req.body.solution;
        params.solution = sol.replace(/\'/g, "''");
    }
    if (descExists) {
        desc = req.files.description.data.toString("utf8") || req.body.description;
        params.description = desc.replace(/\'/g, "''");
    }
    
    const result = await insertIntoTable('tasks', params);
    if(result.error)
        return res.status(500).send({message: "Failed to insert task"});
    return res.status(200).send({message: "Task created successfully!"});
});

/**
 * delete task/s
 * 
 * req.body: [
 *              {
 *                  taskid, taskname, sectionid, groupid
 *              }
 *          ]
 */
 router.delete("/", isAuth, protector(["admin", "demonstrator"]), async (req, res, next) => {

    const result = await deleteFromTable('tasks', req.body);

    if (result.error)
        res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    return res.status(200).send(JSON.stringify({message: "Tasks successfully updated"}));
});

/**
 * update task/s
 * 
 * req.body: [
 *              {
 *                  task: {taskid, taskname, sectionid, groupid},
 *                  diff: {taskid?, taskname?, sectionid?, groupid?}
 *              }
 *          ]
 */
 router.put("/update", isAuth, protector(["admin", "demonstrator"]), async (req, res, next) => {

    const updateResult = await updateTable('tasks', req.body.task, req.body.diff);

    if (updateResult.error)
        res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    return res.status(200).send(JSON.stringify({message: "Tasks successfully updated"}));
});

module.exports = router;
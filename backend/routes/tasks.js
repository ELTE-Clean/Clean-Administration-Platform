/* Handles database functionalities /db/.... */

/* Dependencies Importing */
const router = require('express-promise-router')();     // Used to handle async request. Will be useful in the future to dodge the pyramid of doom
const selectFromTable = require('../utils/database_utils').selectFromTable;
const insertIntoTable = require('../utils/database_utils').insertIntoTable;
const deleteFromTable = require('../utils/database_utils').deleteFromTable;
const isAuth = require('../utils/keycloak_utils').isAuth;
const protector= require('../utils/keycloak_utils').protector;
const fileUpload = require('express-fileupload');


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
        parameters.sectionid = req.query.sectionid;
    if(req.query.groupid)
        parameters.groupid = req.query.groupid;
    if(req.query.taskid)
        parameters.taskid = req.query.taskid;

    /* Get task/s */
    const result = await selectFromTable('tasks', parameters);
    if (result.error) 
        return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));

    /* Decide what to return */
    const filtered = result.result.rows.map(task => {
        let finalShape = {
            taskid: task.taskid, 
            sectionid: task.sectionid, 
            groupid : task.groupid,
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
 *  - solution
 *  - description
 * 
 */
router.post('/create', fileUpload({createParentPath: true}), isAuth, protector(['admin', 'demonstrator']),  async (req, res, next) => {


    if(!req.files || !req.files.solution || !req.files.description)
        return res.status(400).send({message: "Description or Solution are missing!"});

    console.log(req.body);
    console.log(req.files.solution.data.toString('utf8'));
    return res.status(200).send({message: "Files are found"});
});



/**
 * update task/s
 * 
 * req.body: [
 *              {
 *                  task: {groupid, sectionid, taskid},
 *                  newtask: {taskid, description, max, solution}
 *              }
 *          ]
 */
 router.put("/update", isAuth, protector(["admin", "demonstrator"]), async (req, res, next) => {

    // const delResult = await deleteFromTable('tasks', req.query.old);
    // const insResult = await insertIntoTable('tasks', req.query.new);

    // if (delResult.error || insResult.error)
    //     res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    return res.status(200).send(JSON.stringify({message: "Tasks successfully updated"}));
});

module.exports = router;
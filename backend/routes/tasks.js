/* Handles database functionalities /db/.... */

/* Dependencies Importing */
const router = require('express-promise-router')();     // Used to handle async request. Will be useful in the future to dodge the pyramid of doom
const { selectFromTable, insertIntoTable, deleteFromTable, updateTable } = require('../utils/database_utils');
const { isAuth, protector } = require('../utils/keycloak_utils');
const fileUpload = require('express-fileupload');   // Used to parse the incoming formpost files and insert them into req.files
const fs = require('fs');
const {log} = require('../utils/logger_utils');
const util = require('util');
const exec = util.promisify(require('child_process').exec);



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
    if(req.data.sectionid)
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
            taskname: task.taskname,
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
 *  - solution   // The one containing the answers (For the grading script)
 *  - description   // File containing the description of the task
 *
 * The solution and description can be given through the req.body, or passed by a multipart/form_data protocol.
 *
 */
router.post("/create",fileUpload({ createParentPath: true }),isAuth, protector(["admin", "demonstrator"]),async (req, res, next) => {
    /* Check if the the incoming data are complete */
    const fileNotInForm = !req.files || !req.files.solution || !req.files.description;
    const fileNotInBody = !req.body  || !req.body.solution  || !req.body.description; 
    const incompleteFile = fileNotInForm && fileNotInBody;
    const incompleteBody = !req.body || !req.body.taskid || !req.body.sectionid || !req.body.groupid || !req.body.max;
    if(incompleteFile || incompleteBody)
        return res.status(400).send({message: "Description or Solution are missing!"});

    const solution = req.files.solution.data.toString("utf8") || req.body.solution;
    const description = req.files.description.data.toString("utf8") || req.body.description;

    /* Inserting the task into the table */
    const params = {
        taskid: req.body.taskid,
        sectionid: req.body.sectionid,
        groupid: req.body.groupid,
        max: req.body.max,
        solution : solution.replace(/^.*module.*$/g,'').replace(/\'/g, "''"),
        description: description.replace(/\'/g, "''"),
    };
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
router.delete("/",isAuth,protector(["admin", "demonstrator"]),async (req, res, next) => {
    if(!req.body.taskID)
        return res.status(400).send(JSON.stringify({message: "taskID not found"}));
    
    let result = await deleteFromTable("grades", {taskID:  req.body.taskID});
    if (result.error)
        return res.status(500).send(JSON.stringify({ message: "Transaction Failed" }));

    result = await deleteFromTable("tasks", {taskID:  req.body.taskID});
    if (result.error)
        return res.status(500).send(JSON.stringify({ message: "Transaction Failed" }));
    return res.status(200).send(JSON.stringify({ message: "Tasks successfully updated" }));
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
router.put("/update",isAuth,protector(["admin", "demonstrator"]),async (req, res, next) => {
    const updateResult = await updateTable("tasks",req.body.task,req.body.diff);
    if (updateResult.error)
        res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    return res.status(200).send(JSON.stringify({message: "Tasks successfully updated"}));
});


router.post("/:taskID/submit", fileUpload({ createParentPath: true }), isAuth, protector(["student"]), async (req, res, next) => {
    
    console.log(req.body, req.files);
    if(!req.body.userID)
        return res.status(400).send(JSON.stringify({message: "Request body must contain userID"}));

    const fileNotInForm = !req.files || !req.files.submission;
    const fileNotInBody = !req.body  || !req.body.submission;
    const incompleteFile = fileNotInForm && fileNotInBody;
    if(incompleteFile)
        return res.status(400).send(JSON.stringify({message: "No Answer is uploaded"}));

    const uid = req.body.userID;
    const tid = req.params.taskID;
    let submission = req.files.submission.data.toString("utf8") || req.body.submission;

    submission = submission.replace(/^.*module.*$/g, '');
    console.log(submission);

    let result = await insertIntoTable('grades', {userID : uid, taskID: tid, submission: submission });
    if(result.error){
        log("ERROR", result.error.toString());
        return next("Submitting answer failed");
    }
    log("INFO", "A submission has been inserted");

    return res.status(200).send(JSON.stringify({message: "Sumbission is Successfull"}));
});


/**
 * Grade a given task and returns the results of the grading.
 * 
 * Call the endpoit with
 * tasks/1/grade , where the 1 is the task id.
 * 
 */
router.post("/:taskID/grade", isAuth, protector(["admin", "demonstrator"]), async (req, res, next) => {
    const tid = req.params.taskID;
    const gid = req.body.groupID;

    /* Get the task and solutions records */
    const taskRecord = await selectFromTable('tasks', {taskID: tid});
    if(taskRecord.error)
        return next(taskRecord.error);
    if(taskRecord.result.rows.length < 1)
        return res.status(404).send(JSON.stringify({message: "Task does not exist"}));
    if(!taskRecord.result.rows[0].solution)
        return res.status(404).send(JSON.stringify({message: "No teacher solution is given"}));
    
    const studentSolutionRecord = await selectFromTable('grades', {taskID: tid});
    if(studentSolutionRecord.error)
        return next(studentSolutionRecord.error);

    /* Create Directories */
    const taskDir = './grades/tasks/' + tid + '/';
    fs.rmSync(taskDir, { recursive: true, force: true });
    var directories = taskDir.split('/');
    var directories = directories.slice(1, directories.length-1);
    let accum = "./";
    for(let dir of directories){
        accum += dir + "/";
        if(fs.existsSync(accum))
            continue;
        log("DEBUG", "Creating Directory" + accum);
        fs.mkdirSync(accum);
    }

    /* Create Teacher and Student files */
    let config = `teacher_file: ` + taskDir + 'teacher.icl' + `\n`;
    log("INFO", "Creating Teacher Solution File" );
    fs.writeFileSync(taskDir + 'teacher.icl', taskRecord.result.rows[0].solution, (err) => {
        log("ERROR", "Failed to write into file: " + taskDir + 'teacher.icl');
        return next("writeFileSync aborted");
    });
    config += `student_files:\n`;
    studentSolutionRecord.result.rows.forEach(row => {
        if(!row.submission) 
            return;
        const fileName = taskDir + row.userid.toString() + '.icl';
        const code = "module " + row.userid.toString() + "\n" + row.submission;
        log("INFO", "Creating Student File: " + fileName);
        config += `\t- ${fileName}\n`; 
        fs.writeFileSync(fileName, code, (err) => { if (err) log("ERROR", err.toString());});
    });
    config += taskRecord.result.rows[0].testquestions.replace(/\\t/g, '  ');
    config = config.replace(/\t/g, '  ');
    log("DEBUG", `Correction Script Configuration: \n${config}`);

    /* Create the configuration for the python script */
    const configPath = taskDir + 'config.yml';
    fs.writeFileSync(configPath, config, (err) => { 
        if (err) {
            log("ERROR", err.toString());
            return next("Can't generate correction configuration");
        }
    });
    
    /* Run the script on all the folder contents */
    const scriptCode = "python ./scripts/scripts/CorrectTest.py -f " + configPath + " -tn 1";
    log("DEBUG", "Executing Script: " + scriptCode);
    const execRes = await exec(scriptCode);
    if(execRes.stderr){
        log("ERROR", "Execution Result: " + execRes.stderr);
        return next("Failed to run the correction script");
    }
    log("DEBUG", "Execution Result: " + execRes.stdout);
    
    /* Return the script results */
    return res.status(200).send(JSON.stringify({message: "Request Was Successfull", result: execRes.stdout}));
});


module.exports = router;

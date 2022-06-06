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
 * By default, we don't send the description, test cases, nor the solution. To request these,
 * enable them in the query by:
 *  solution=true
 *  description=true
 *  testcases=true
 */
 router.get("/", isAuth, async (req, res, next) => {
    const descriptionEnable = req.query.description == 'true';
    const solutionEnable = req.query.solution == 'true';
    const testCasesEnable = req.query.testcases == 'true';

    /* Construction of the query parameters */
    let parameters = {};
    if(req.query.sectionid)
        parameters.sectionid = req.query.sectionid;
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
            max : task.max,
            dueDate : task.expirydate,
            dueTime : task.expirytime
        };

        if(solutionEnable)
            finalShape.solution = task.solution;
        if(descriptionEnable)
            finalShape.description = task.description;
        if(testCasesEnable)
            finalShape.testcasesText = task.testquestions;
        return finalShape;
    });

    return res.status(200).send(JSON.stringify(filtered));
});


/**
 * Get specific task submission details. If a user ID is specified in the query, 
 * then we return the submission of that specific user. 
 * If not, we return all the submissions of the users assigned with that task.
 * By default, we don't send the submission itself. To request this,
 * enable it in the query by:
 *  submission=true
 * The solution will be appended at the end of the result.
 */
 router.get("/:taskID/submissions", isAuth, async (req, res, next) => {
    const submissionEnable = req.query.submission == 'true';

    const tid = req.params.taskID;
    const uid = req.query.userID;

    /* Construction of the query parameters */
    let parameters = {taskID: tid};
    if (uid) parameters.userID = uid;

    /* Get grade/s */
    const result = await selectFromTable('grades', parameters);
    if (result.error) 
        return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    
    const data = result.result.rows.map(sub => {
        let finalShape = {
            userid: sub.userid,
            taskid: sub.taskid,
            gradeid: sub.gradeid,
            grade: sub.grade
        };

        if (submissionEnable) {
            finalShape.filename = sub.filename;
            finalShape.submission = sub.submission;
        }

        return finalShape;
    });

    return res.status(200).send(JSON.stringify(data));
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
    const incompleteBody = !req.body || !req.body.name || !req.body.sectionid;
    if(incompleteFile || incompleteBody)
        return res.status(400).send({message: "Missing input parameters!"});

    const solution = req.files?.solution.data.toString("utf8") || req.body.solution;
    const description = req.files?.description.data.toString("utf8") || req.body.description;

    const ts = new Date();
    /* Inserting the task into the table */
    const params = {
        sectionid : req.body.sectionid,
        max : req.body.maxGrade,
        taskname: req.body.name,
        expiryDate : req.body.dueDate  || `${ts.getFullYear()}-${ts.getMonth()}-${ts.getDay()}`,
        expiryTime : req.body.dueTime ||  `${ts.getHours()}:${ts.getMinutes()}:${ts.getSeconds()}`,
        solution : solution.replace(/^.*module.*$/g,'').replace(/\'/g, "''"),
        description : description.replace(/\'/g, "''"),
        testquestions : req.body.testcases
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
router.delete("/",isAuth, protector(["admin", "demonstrator"]), async (req, res, next) => {
    if(!req.body.taskID)
        return res.status(400).send(JSON.stringify({message: "taskID not found"}));
    
    const params = {taskID: req.body.taskID};
    let result = await deleteFromTable("grades", params );
    if (result.error)
        return res.status(500).send(JSON.stringify({ message: "Transaction Failed" }));

    result = await deleteFromTable("tasks", params);
    if (result.error)
        return res.status(500).send(JSON.stringify({ message: "Transaction Failed" }));
    return res.status(200).send(JSON.stringify({ message: "Task successfully deleted" }));
});


/**
 * update task/s
 *
 * 
 * req.body:    {
 *                  diff: {taskname?, sectionid?, solution?, testcases?, description?, expiryDate?, expiryTime?}
 *              }
 *          
 * req.files: {solution? , description? }
 * NOTE:
 *  Date : yy-mm-dd ... E.g: 2022-11-13
 *  Time : h:m:s ... E.g: 10:02:10
 */
router.put("/:taskID/update",fileUpload({ createParentPath: true }), isAuth, protector(["admin", "demonstrator"]),async (req, res, next) => {
    const tid = req.params.taskID;
    let result = await selectFromTable("tasks", {taskID:tid});
    if (result.error)
        res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    
    const oldTask = result.result.rows[0];

    let ts = new Date();

    const params = {
        solution : req.files?.solution.data.toString("utf8") || req.body.solution || oldTask.solution,
        description : req.files?.description.data.toString("utf8") || req.body.description || oldTask.description,
        taskname : req.body.taskname || oldTask.taskName,
        sectionid : req.body.sectionid || oldTask.sectionID,
        expiryDate : req.body.dueDate || oldTask.expiryDate || `${ts.getFullYear()}-${ts.getMonth()}-${ts.getDay()}`,
        expiryTime : req.body.dueTime || oldTask.expiryTime|| `${ts.getHours()}:${ts.getMinutes()}:${ts.getSeconds()}`,
        testquestions : req.body.testcases || oldTask.testQuestions
    };

    const updateResult = await updateTable("tasks", {taskID: tid}, params);
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
    const filename = req.files.submission.name.toString("utf8") || req.body.filename;
    let submission = req.files.submission.data.toString("utf8") || req.body.submission;

    submission = submission.replace(/^.*module.*$/g, '');
    console.log(submission);

    let result = await insertIntoTable('grades', {userID : uid, taskID: tid, filename: filename, submission: submission });
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

    /* Convert test cases to yaml */
    let testYaml = "test_questions:\n";
    JSON.parse(taskRecord.result.rows[0].testquestions).forEach((question, i) => {
        testYaml += `\t- q${i}:\n`
        testYaml += `\t\tfunction_name: ${question.functionname}\n`;
        testYaml += `\t\ttest_cases:\n`;
        question.parameters.forEach(parameter => {
            testYaml += `\t\t\t- ${parameter}\n`;
        });
    });

    config += testYaml.replace(/\\t/g, '  ');
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

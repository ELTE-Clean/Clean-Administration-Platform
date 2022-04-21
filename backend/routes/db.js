/* Handles database functionalities /db/.... */

/* Dependencies Importing */
const router = require('express-promise-router')();     // Used to handle async request. Will be useful in the future to dodge the pyramid of doom
const selectFromTable = require('../utils/database_utils').selectFromTable;
const insertIntoTable = require('../utils/database_utils').insertIntoTable;
const deleteFromTable = require('../utils/database_utils').deleteFromTable;
const isAuth = require('../utils/keycloak_utils').isAuth;
const  protector= require('../utils/keycloak_utils').protector;


/**
 * Get all sections.
 */
router.get("/section/all", isAuth, async (req, res, next) => {
    const result = await selectFromTable('sections');
    if (result.error) res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    res.status(200).send(JSON.stringify({message: result.result.rows}));
});

/**
 * Add a new section to a group.
 */
router.post("/section/add", isAuth, protector(["admin", "demonstrator"]), async (req, res, next) => {
    const result = await insertIntoTable('sections', req.body);
    if (result.error) res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    res.status(200).send(JSON.stringify({message: "New section added"}));
});

/**
 * Get all tasks for a specific section.
 */
router.get("/section/tasks/all", isAuth, async (req, res, next) => {
    if (!req.query.sectionid) res.status(500).send(JSON.stringify({message: "Transaction Failed, section not provided"}));
    const result = await selectFromTable('tasks', req.query);
    if (result.error) res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    res.status(200).send(JSON.stringify({message: result.result.rows}));
});

/**
 * Edit a section
 */
router.put("/section/edit", isAuth, protector(["admin", "demonstrator"]), async (req, res, next) => {
    const delResult = await deleteFromTable('sections', req.query.old);
    const insResult = await insertIntoTable('sections', req.query.new);

    if (delResult.error || insResult.error)
        res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    res.status(200).send(JSON.stringify({message: "Sections successfully updated"}));
});

/**
 * Edit a task
 */
router.put("/task/edit", isAuth, protector(["admin", "demonstrator"]), async (req, res, next) => {
    const delResult = await deleteFromTable('tasks', req.query.old);
    const insResult = await insertIntoTable('tasks', req.query.new);

    if (delResult.error || insResult.error)
        res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    res.status(200).send(JSON.stringify({message: "Tasks successfully updated"}));
});

/**
 * Add students
 */
router.put("/students/add", isAuth, protector(["admin", "demonstrator"]), async (req, res, next) => {
    for (const student of Object.entries(req.body)) {
        const result = await insertIntoTable('users', student);
        if (result.error) res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    }
    res.status(200).send(JSON.stringify({message: "Students successfully added"}));
});

/**
 * Assign a user to group
 */
router.put("/group/assign", isAuth, protector(["admin", "demonstrator"]), async (req, res, next) => {
    const result = await insertIntoTable('user_to_group', req.body);
    if (result.error) res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    res.status(200).send(JSON.stringify({message: "User successfully assigned to group"}));
});

/**
 * Unassign a user from group
 */
router.delete("/group/unassign", isAuth, protector(["admin", "demonstrator"]), async (req, res, next) => {
    const result = await deleteFromTable('user_to_group', req.body);
    if (result.error) res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    res.status(200).send(JSON.stringify({message: "User successfully unassigned from group"}));
});

module.exports = router;

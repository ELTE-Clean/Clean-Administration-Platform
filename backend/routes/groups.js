/* Handles database functionalities /db/.... */

/* Dependencies Importing */
const router = require('express-promise-router')();     // Used to handle async request. Will be useful in the future to dodge the pyramid of doom
const selectFromTable = require('../utils/database_utils').selectFromTable;
const insertIntoTable = require('../utils/database_utils').insertIntoTable;
const deleteFromTable = require('../utils/database_utils').deleteFromTable;
const isAuth = require('../utils/keycloak_utils').isAuth;
const  protector= require('../utils/keycloak_utils').protector;




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
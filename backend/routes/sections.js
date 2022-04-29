/* Handles database functionalities /db/.... */

/* Dependencies Importing */
const router = require('express-promise-router')();     // Used to handle async request. Will be useful in the future to dodge the pyramid of doom
const selectFromTable = require('../utils/database_utils').selectFromTable;
const insertIntoTable = require('../utils/database_utils').insertIntoTable;
const deleteFromTable = require('../utils/database_utils').deleteFromTable;
const isAuth = require('../utils/keycloak_utils').isAuth;
const  protector= require('../utils/keycloak_utils').protector;



/**
 * Get section/s
 * req.query: {sectionid, groupid}
    * If "GROUP ID" is null, then only the section ID is serched for
    * if "SECTION ID" is null, then we only get by the group ID.
    * IF "SECTION ID and GROUP ID" are defined, we get the specific section
    * If "req.query" is empty or null, we get all sections.
 * 
 */
 router.get("/", isAuth, async (req, res, next) => {
    let ret;
    if (!req.query)
        ret = await selectFromTable('sections');
    else if(!req.query.groupid)
        ret = await selectFromTable('sections', {sectionid : section.sectionid});
    else if(!req.query.sectionid)
        ret = await selectFromTable('sections', {groupid : section.groupid});
    else    
        ret = await selectFromTable('sections', {sectionid : section.sectionid, groupid : section.groupid});

    if (ret.error)
        return res.status(500).send(JSON.stringify({message: "Getting Sections Failed"}));
    
    return res.status(200).send(JSON.stringify(ret.result.rows));
});



/**
 * Creates a new section to a group.
 * req.body: {sectionid, groupid}
 */
router.post("/create", isAuth, protector(["admin", "demonstrator"]), async (req, res, next) => {
    const result = await insertIntoTable('sections', req.body);
    if (result.error) 
        return res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    return res.status(200).send(JSON.stringify({message: "Section successfully added"}));
});



/**
 * Delete section/s from a table with given parameters. The operation is a junction AND operation.
 * req.body: [{sectionid, groupid}]
 *   * If "GROUP ID" is null, then sections with the given ID are deleted
 *   * if "SECTION ID" is null, then all sections belong to the given group id are deleted
 *   * IF "SECTION ID and GROUP ID" are defined, delete that specific section
 */
 router.delete("/", isAuth, protector(["admin", "demonstrator"]), async (req, res, next) => {
    if(!req.body || req.body.length === 0)
        return res.status(400).send(JSON.stringify({message: "No sectoin is given to be deleted"}));

    let unsuccess = [];
    for(const section of req.body){
        let result;
        if(!section.sectionid)
            result = await deleteFromTable('sections', {groupid: section.groupid});
        else if(!section.groupid)
            result = await deleteFromTable('sections', {sectionid: section.sectionid});
        else    
            result = await deleteFromTable('sections', {sectionid: section.sectionid, groupid: section.groupid});

        if (result.error) 
            unsuccess = [...unsuccess, section]
    };

    if(unsuccess.length > 0)
        return res.status(200).send(JSON.stringify({message: "Not all sections have been deleted", unsuccess: unsuccess}));
    else
        return res.status(200).send(JSON.stringify({message: "Sections have been deleted successfully"}));
});



/**
 * Edit a section
 */
 router.put("/update", isAuth, protector(["admin", "demonstrator"]), async (req, res, next) => {
    const delResult = await deleteFromTable('sections', req.query.old);
    const insResult = await insertIntoTable('sections', req.query.new);

    if (delResult.error || insResult.error)
        res.status(500).send(JSON.stringify({message: "Transaction Failed"}));
    res.status(200).send(JSON.stringify({message: "Sections successfully updated"}));
});


module.exports = router;
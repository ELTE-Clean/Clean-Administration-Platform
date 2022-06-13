/* Handles database functionalities /db/.... */

/* Dependencies Importing */
const router = require("express-promise-router")(); // Used to handle async request. Will be useful in the future to dodge the pyramid of doom
const {
  selectFromTable,
  insertIntoTable,
  deleteFromTable,
  updateTable,
} = require("../utils/database_utils");
const isAuth = require("../utils/keycloak_utils").isAuth;
const protector = require("../utils/keycloak_utils").protector;

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
  const result = await selectFromTable("sections");
  if (result.error)
    return res
      .status(500)
      .send(JSON.stringify({ message: "Getting Sections Failed" }));

  return res.status(200).send(JSON.stringify(result.result.rows));
});

/**
 * Creates a new section to a group.
 * req.body: {sectionid, groupid}
 */
router.post(
  "/create",
  isAuth,
  protector(["admin", "demonstrator"]),
  async (req, res, next) => {
    const result = await insertIntoTable("sections", req.body);
    if (result.error)
      return res
        .status(500)
        .send(JSON.stringify({ message: "Transaction Failed" }));
    return res
      .status(200)
      .send(JSON.stringify({ message: "Section successfully added" }));
  }
);

/**
 * Delete section from a table with given parameters. The operation is a junction AND operation.
 * req.body: {sectionid}
 */
router.delete(
  "/",
  isAuth,
  protector(["admin", "demonstrator"]),
  async (req, res, next) => {
    if (!req.body || req.body.length === 0)
      return res
        .status(400)
        .send(JSON.stringify({ message: "No section is given to be deleted" }));

    const section = await selectFromTable("sections", req.body);
    if (section.error) next("Could not get section");
    if (section.result.rowCount === 0) next("Section does not exist");

    const tasksToRemove = await selectFromTable("tasks", req.body);
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

    return res
      .status(200)
      .send(
        JSON.stringify({ message: "Section has been deleted successfully" })
      );
  }
);

/**
 * Edit a section
 *
 * req.body: [
 *              {
 *                  section: {sectionid, sectionname, groupid},
 *                  diff: {sectionid?, sectionname?, groupid?}
 *              }
 *          ]
 */
router.put(
  "/update",
  isAuth,
  protector(["admin", "demonstrator"]),
  async (req, res, next) => {
    const updateResult = await updateTable(
      "sections",
      req.body.section,
      req.body.diff
    );

    if (updateResult.error)
      res.status(500).send(JSON.stringify({ message: "Transaction Failed" }));
    res
      .status(200)
      .send(JSON.stringify({ message: "Sections successfully updated" }));
  }
);

module.exports = router;
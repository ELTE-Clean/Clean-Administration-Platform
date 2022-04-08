const { execTrans } = require('../utils/database_utils');

/* Dependencies Importing */
const router = require('express-promise-router')();     // Used to handle async request. Will be useful in the future to dodge the pyramid of doom
const keycloak = require('../utils/keycloak_utils').keycloak;
const protector = require('../utils/keycloak_utils').protector;
const isAuth = require('../utils/keycloak_utils').isAuth;
const isUnauth = require('../utils/keycloak_utils').isUnauth;
const execQuery = require('../utils/database_utils').execQuery;
const startTrans = require('../utils/database_utils').startTrans;
const endTrans = require('../utils/database_utils').endTrans;
const log = require('../utils/logger_utils').log;

/* Importing Routers */
const usersRouter = require('./users');


router.use('/users', usersRouter);


// --------------------------------------- Main Endpoint ---------------------------------------

/**
 * This route is for testing if the user is authenticated or not. Only authenticated user can access
 *  this route. 
 * * keycloak.protect(function()) : This will check if user is authenticated and use a simple 
 *      protector (Costum made) function to check if the user is authurized or not.
 * * isAuth : is another costum middleware that we defined. It just check if there is a 
 *      keycloak.grant somewhere in the session.
 */
 router.get("/main/student", keycloak.protect('realm:student'), isAuth, (req, res, next) => {
    keycloak.getGrant(req, res).then((grant) => {
        res.status(200).send(JSON.stringify({message: "User is logged in and authenticated!"}));
    }).catch( err => {
        console.log(err);
        return next("User must be authenticated to access this page.");
    });
});

router.get("/main/demonstrator", keycloak.protect('realm:demonstrator'), isAuth, (req, res, next) => {
    keycloak.getGrant(req, res).then((grant) => {
        res.status(200).send(JSON.stringify({message: "User is logged in and authenticated!"}));
    }).catch( err => {
        console.log(err);
        return next("User must be authenticated to access this page.");
    });
});

// --------------------------------------- Autherization Endpoints ---------------------------------------

/**
 * A simple login endpoint to check if everything is working perfectly. In real applications we will not need this one.
 */
router.get("/login", isUnauth, (req, res, next) => {
    keycloak.grantManager.obtainDirectly('student-1', '123').then(
        (grant) => {
            keycloak.storeGrant(grant, req, res);
            res.status(200).send(JSON.stringify({response: `user \"student-1\" is logged in.`}))
        }
    ).catch((error) => {console.log(error); return next(error)});
});


/**
 * A production-level /login endpoint. 
 */
router.post("/login", isUnauth, (req, res, next) => {
    let username = req.body.username;
    let password = req.body.password;
    log("DEBUG", `/login: User details: ${username} , ${password}`);
    
    // Log-in using the keycloak grantManager object.
    keycloak.grantManager.obtainDirectly(username, password)
    .then((grant) => {
            keycloak.storeGrant(grant, req, res);   // we store the grant (Tokens and stuff) in the req.session as 'keycloak-token'
            res.status(200).send(JSON.stringify({response: `user ${username} is logged in successfully.`}))
    })
    .catch((error) => {console.log(error); return next(error)});
});


/**
 * This will logout the user, destroy the session data that correspond to that user. Note that, it won't 
 *  delete the session, but it will only destroy the keycloak data attached to that session. 
 *  So other arbitrary data can still be saved in the session. 
 * 
 */
router.get("/logout", isAuth, (req, res, next) => {
    let sid = req.session.id;
    keycloak.unstoreGrant(sid);     // destroys the keycloak data corresponding to this session.
    res.status(200).send(JSON.stringify({message: "User is Logged out and session has been destroyed"}));
});

// --------------------------------------- Database Endpoints ---------------------------------------

/**
 * Test endpoints to see if we can interact 
 * with the database 
 */
router.get("/select/:table", (req, res, next) => {
    let qryText = "select * from " + req.params.table;
    if (Object.entries(req.query).length > 0) {
        const pairs = Object.entries(req.query).map( ([key, val]) => key+ "='" + val + "'" );
        const filter = " where " + pairs.join(" and ");
        qryText += filter;
    }
    qryText += ";"

    const qry = { text: qryText };
    log("DEBUG", qryText);

    execQuery(qry)
    .then((result) => res.status(200).send(JSON.stringify({message: result.result.rows})))
    .catch((error) => {console.log(error); return next(error)});;
});

router.get("/insert/:table", (req, res, next) => {
    let qryText = "insert into " + req.params.table;
    const cols = " (" + Object.keys(req.query).join(", ") + ")";
    const vals = " values (" + Object.values(req.query).map( val => "'" + val + "'" ).join(", ") + ")";
    qryText += cols + vals + ";";

    const qry = { text: qryText };
    execQuery(qry)
    .then(res.status(200).send(JSON.stringify({message: "Insert successful, table '" + req.params.table + "' updated!"})));
});

router.get("/delete/:table", (req, res, next) => {
    let qryText = "delete from " + req.params.table;
    const pairs = Object.entries(req.query).map( ([key, val]) => key+ "='" + val + "'" );
    const filter = " where " + pairs.join(" and ");
    qryText += filter + ";";

    const qry = { text: qryText };
    execQuery(qry)
    .then(res.status(200).send(JSON.stringify({message: "Delete successful, table '" + req.params.table + "' updated!"})));
});

router.get("/transaction", (req, res, next) => {
    const qry = { text: "select * from grades;" };
    startTrans().then(transInstance => {
        execTrans(qry, transInstance).then(result => {
            endTrans(transInstance).then(
                res.status(200).send(JSON.stringify({message: result.result.rows}))
            )
        })
    })
});

module.exports = router;

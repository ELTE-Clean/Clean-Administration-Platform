/* Dependencies importing. */
const   express       = require('express');
const   cookieParser  = require('cookie-parser');
const   bodyParser    = require('body-parser');
const   fs            = require('fs');
const   session       = require('express-session');

/* Costum dependencies importing. */
const   mainRouter    = require('./routes/main');


/* PREDEFINED CONFIGURATIONS */
const  SESSION_SECRET = 'some secret';  // For future use (For the express session)
const  TLS_PATHS      = "/etc/tls/";    // For future use (If HTTPS is needed).
const  STATIC_ROOT    = "./";           // For future use (Sets the express static directory roots (Front end files distenation))
const  PORT           = 5000;           // Port of the backend server.

/* Global variables */
const   memoryStore   = require('./utils/keycloak_utils').memoryStore;  //new session.MemoryStore();
const   app_session   = session({ secret:SESSION_SECRET, resave: false, saveUninitialized: true, store: memoryStore});
var     app           = express();
const   keycloak      = require('./utils/keycloak_utils').keycloak;

/* Session middlewares */
app.use(app_session);
app.use(keycloak.middleware());

/* setting up parsing middlewares */
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cookieParser());

/* Setting up static paths. */
app.use(express.static(STATIC_ROOT));

/* Handling requests via routers */
app.use(mainRouter);

/* after logging out, redirect the request to the root page. */
// app.use( keycloak.middleware( { logout: '/'} ));

/* If we have a certificate for https, then we create a https se */
if (fs.existsSync(TLS_PATHS)) {     // if the tls folder exist.
    var https = require('https');
    var privateKey = fs.readFileSync(`${tls_path}/tls.key`, 'utf8');
    var certificate = fs.readFileSync(`${tls_path}/tls.crt`, 'utf8');
    var credentials = { key: privateKey, cert: certificate };
    var httpsServer = https.createServer(credentials, app);
    httpsServer.listen(PORT,"localhost",(error)=>{
        if(error){
            console.error(error);
        }
        else{
            console.log('Server starting on port ' + PORT);
        }
    });
}else{ // http setup.
    app.listen(PORT, console.log('Server started on port ' + PORT));
}
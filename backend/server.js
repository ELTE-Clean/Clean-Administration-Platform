/* Dependencies importing. */

const   express       = require('express');
const   cookieParser  = require('cookie-parser');
const   bodyParser    = require('body-parser');
const   fs            = require('fs');
const   session       = require('express-session');


/* Costum dependencies importing. */
const   mainRouter    = require('./routes/main');
const   errorHandler  = require('./middlewares/error_handlers');
const   corsHandler   = require('./middlewares/prepro_handlers');    // Allowing XMLHTTPREQUESTs

/* PREDEFINED CONFIGURATIONS */
const SESSION_SECRET = "some secret"; // For future use (For the express session)
const TLS_PATHS = "/etc/tls/"; // For future use (If HTTPS is needed).
const STATIC_ROOT = "./"; // For future use (Sets the express static directory roots (Front end files distenation))
const PORT = 5000; // Port of the backend server.

/* Global variables */
const memoryStore = require("./utils/keycloak_utils").memoryStore; //new session.MemoryStore();
const app_session = session({
  secret: SESSION_SECRET,
  resave: false,
  saveUninitialized: true,
  store: memoryStore,
});
var app = express();
const keycloak = require("./utils/keycloak_utils").keycloak;

/* Session middlewares */
app.use(app_session);

// Configuring body parser middleware
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cookieParser());
app.use(corsHandler);


/* 
    This middleware (below) setup many of the keycloak configurations and variables to the request bodies.
    Note that the logout url is just a garbage url. If I don't assign this url to anything or if I put it 
    null, it will use the default /logout path as its endpoint. So if a client requested to /api/v1/logout, this middleware will jump to the request and redirect the request. I searched for turning
    this off, but didn't find much clues on how to do that. I tried:
    logout : undefined 
    logout : '' 
    and both activates the default behaviour of this middleware (The one that we don't want). Another solution,
    will be to catch the /logout first and then redirect it to something like /logoff before this middleware is activated.
*/
app.use(
  keycloak.middleware({
    admin: "/",
    logout:
      "/this_url_redirects_to_the_keycloak_logout_page_which_is_useless_but_we_cant_set_it_to_be_equal_to_null_or_it_will_use_the_default_behavior",
  })
);

/* Setting up static paths. */
app.use(express.static(STATIC_ROOT));

/* Handling requests via routers */
app.use(mainRouter);

/* Handling errors */
app.use(errorHandler);

/* If we have a certificate for https, then we create a https se */
if (fs.existsSync(TLS_PATHS)) {
  // if the tls folder exist.
  var https = require("https");
  var privateKey = fs.readFileSync(`${tls_path}/tls.key`, "utf8");
  var certificate = fs.readFileSync(`${tls_path}/tls.crt`, "utf8");
  var credentials = { key: privateKey, cert: certificate };
  var httpsServer = https.createServer(credentials, app);
  httpsServer.listen(PORT, "localhost", (error) => {
    if (error) {
      console.error(error);
    } else {
      console.log("Server starting on port " + PORT);
    }
  });
} else {
  // http setup.
  app.listen(PORT, console.log("Server started on port " + PORT));
}

const log = require('../utils/logger_utils').log;


const errorHandler = (err, req, res, next) => {
    if(err) {
        log("ERROR", err.toString());
        res.status(500).send(JSON.stringify({message: `Error: ${err}`}));
    }
    next();
}

module.exports = errorHandler;
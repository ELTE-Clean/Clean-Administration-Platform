/**
 * This module is responsible for pre-processing the incoming requests and responses.
 * 
 */

const corsHandler = (req, res, next) => {
    res.set('Access-Control-Allow-Origin', req.headers.origin); //req.headers.origin
    res.set('Access-Control-Allow-Credentials', 'true');
    res.set("Access-Control-Allow-Methods", "GET,HEAD,OPTIONS,POST,PUT");
    res.set("Access-Control-Allow-Headers", "Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers");
    next();
};


module.exports = corsHandler;
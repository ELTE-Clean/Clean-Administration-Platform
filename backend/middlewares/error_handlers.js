
const errorHandler = (err, req, res, next) => {
    if(err)
        res.status(500).send(JSON.stringify({message: "Internal Server Error"}));
    next();
}

module.exports = errorHandler;
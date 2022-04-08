import {Pool, PoolConfig, QueryConfig, QueryResult,PoolClient, QueryResultRow} from "pg";

const log = require('./logger_utils').log;

const poolConfig : PoolConfig = {
    user: process.env.USER_DB,                  // e.g: 'dbuser',
    host: process.env.HOST_DB,                  // e.g: 'database.server.com',
    database: process.env.NAME_DB ,             // e.g: 'mydb',
    password: process.env.PASSWORD_DB,          // e.g: 'secretpassword',
    port: parseInt(process.env.PORT_DB || '')   // e.g: 3211,
};

const pool = new Pool(poolConfig);    // Uses the environment variables to connect to the database

/* Setting up the Pool */
// it contains if a backend error or network partition happens
pool.on('error', (err, client) => {
    log("ERROR", '[POSTGRES POOL]: Unexpected error on idle client');
    process.exit(-1)
});


//--------------------------------------- Interfaces Area ---------------------------------------


/**
 * A simple interface (Object template).
 */
export interface QryResult {
    result?: QueryResult;
    error?: any;
}



/** 
 * Transaction result interface is the default return type of any *Trans() function. 
 * 
 * */
export interface TransactionInstance {
    client?: PoolClient;
    result?: QueryResult;
    error?: any;
}

// --------------------------------------- Methods Area ---------------------------------------

/**  
 * A simple interface for executing simple queries. 
 *  For complicated transactions please don't use this one.
 * Usage example:
 * 
 *  * let {rows, error} = await execQuery(qry);
 *  * if(error) ...
 * 
 * 
*/
export async function execQuery (qry: QueryConfig): Promise<QryResult> {
    try{
        const result = await pool.query(qry);
        let ret : QryResult = {result : result};
        return ret;
    }catch(err){
        log("ERROR", '[QUERY EXEC]: ' + err);
        let ret : QryResult = {error: err};
        return ret;
    }
};


/**
 * Start a transaction
 * @returns Transaction instance which can be used in the execTrans and endTrans. 
 */
export async function startTrans() : Promise<TransactionInstance> {
    try{
        const client : PoolClient = await pool.connect();
        client.query('BEGIN');
        return {client : client} as TransactionInstance;
    }catch(err){
        log("ERROR", '[TRANSACTION START]: ' +  err);
        return {error : err} as TransactionInstance;
    }
};


/**
 * Execute a query on the transaction.
 * @param qry - Query object hold the data of the query.
 * @param transInst - The transaction Instance being used.
 * @returns - Transaction instance with the used client and the query result.
 */
export async function execTrans(qry : QueryConfig, transInst : TransactionInstance) : Promise<TransactionInstance> {
    /* Pre conditional checking before adding the transaction to the current client */
    if(!transInst.client){
        transInst.error = "Undefined client used in transaction";
        log("ERROR", "[TRANSACTION EXEC]: Undefined client used in transaction");
        return transInst;
    }
    if(transInst.error){
        if(transInst.client){
            transInst.client.query('ROLLBACK');
            transInst.client.release();
            transInst.error = "Transaction instance contains an error already. Transaction client has been released for safety";
            log("ERROR", "[TRANSACTION EXEC]: Transaction instance contains an error already. Transaction client has been released for safety");
            return transInst;
        }
        transInst.error = "Transaction instance contains an error already";
        log("ERROR", "[TRANSACTION EXEC]: Transaction instance contains an error already.");
        return transInst;
    }

    /* Processing the transaction */
    try{
        const result : QueryResult = await transInst.client.query(qry);
        transInst.result = result;
        return transInst;
    }catch(err){
        log("ERROR", '[TRANSACTION EXEC]: ' + err);
        transInst.client.query('ROLLBACK');
        transInst.client.release();
        transInst.client = undefined;
        transInst.error = err;
        log("DEBUG", "[TRANSACTION EXEC]: Client has been released");
        return transInst;
    }
};



/**
 * Call this function whenever you want to clear the instance and end the transaction (Commit it).
 * @param transInst - Holds the transaction instance.
 */
export async function endTrans(transInst : TransactionInstance) : Promise<void> {
    if(transInst.error){
        log("ERROR", "[TRANSACTION END]: Transaction Instance contain an error!");
        if(transInst.client){
            await transInst.client.query('ROLLBACK');
            transInst.client.release();
            log("DEBUG", "[TRANSACTION END]: Transaction client is released and transaction is rolled back");
        }
    }

    if(transInst.client){
        await transInst.client.query('COMMIT');
        transInst.client.release();
        log("DEBUG", "[TRANSACTION END]: Transaction Committed Successfully!");
    }
};

/**
 * Execute a full SELECT query.
 * @param table - Query object hold the data of the query.
 * @param params - Object of key and value pairs which corresponds to the column names and values of the table.
 * @returns - Transaction instance with the used client and the query result.
 */
export async function selectFromTable(table : string, params? : Object) : Promise<TransactionInstance> {
    let qryText = "select * from " + table;
    if (params != null && Object.entries(params).length > 0) {
        const pairs = Object.entries(params).map( ([key, val]) => key + "='" + val + "'" );
        const filter = " where " + pairs.join(" and ");
        qryText += filter;
    }
    qryText += ";"

    const qry = { text: qryText };
    log("DEBUG", "[SELECT QUERY]: " + qryText);

    const transInstance = await startTrans()
    await execTrans(qry, transInstance);
    await endTrans(transInstance);
    return transInstance;
}

/**
 * Execute a full INSERT query.
 * @param table - Query object hold the data of the query.
 * @param params - Object of key and value pairs which corresponds to the column names and values of the table.
 * @returns - Transaction instance with the used client and the query result.
 */
export async function insertIntoTable(table : string, params : Object) : Promise<TransactionInstance> {
    let qryText = "insert into " + table;
    const cols = " (" + Object.keys(params).join(", ") + ")";
    const vals = " values (" + Object.values(params).map( val => "'" + val + "'" ).join(", ") + ")";
    qryText += cols + vals + ";";

    const qry = { text: qryText };
    log("DEBUG", "[INSERT QUERY]: " + qryText);

    const transInstance = await startTrans();
    await execTrans(qry, transInstance);
    await endTrans(transInstance);
    return transInstance;
}

/**
 * Execute a full DELETE query.
 * @param table - Query object hold the data of the query.
 * @param params - Object of key and value pairs which corresponds to the column names and values of the table.
 * @returns - Transaction instance with the used client and the query result.
 */
export async function deleteFromTable(table : string, params : Object) : Promise<TransactionInstance> {
    let qryText = "delete from " + table;
    const pairs = Object.entries(params).map( ([key, val]) => key + "='" + val + "'" );
    const filter = " where " + pairs.join(" and ");
    qryText += filter + ";";

    const qry = { text: qryText };
    log("DEBUG", "[DELETE QUERY]: " + qryText);

    const transInstance = await startTrans();
    await execTrans(qry, transInstance);
    await endTrans(transInstance);
    return transInstance;
}

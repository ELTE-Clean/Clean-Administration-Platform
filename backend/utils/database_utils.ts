import {Pool, PoolConfig, QueryConfig, QueryResult,PoolClient, QueryResultRow} from "pg";

// PGHOST='localhost'
// PGUSER=process.env.USER  
// PGDATABASE=process.env.USER
// PGPASSWORD=null
// PGPORT=5432


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
    console.error('[ERROR]: [POSTGRE POOL]: Unexpected error on idle client', err)
    process.exit(-1)
});


//--------------------------------------- Interfaces Area ---------------------------------------


/**
 * A simple interface (Object template).
 */
export interface QryResult {
    result: QueryResult | null;
    error: any;
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
        let ret : QryResult = {result : result, error: null};
        return ret;
    }catch(err){
        console.log("[ERROR]: [QUERY EXEC]: ", err);
        let ret : QryResult = {result : null, error: err};
        return ret;
    }
};


/**
 * Start a transaction and returns the client responsible for the transaction.
 * @returns Transaction instance which can be used in the execTrans and endTrans. 
 */
export async function startTrans() : Promise<TransactionInstance> {
    try{
        const client : PoolClient = await pool.connect();
        client.query('BEGIN');
        return {client : client} as TransactionInstance;
    }catch(err){
        console.log("[ERROR]: [TRANSACTION START]: ", err);
        return {error : err} as TransactionInstance;
    }
};


/**
 * Execute a query on the transaction. Returns the transacation instance which contain the result of the executed query.
 * @param qry - Query object hold the data of the query.
 * @param transInst - The transaction Instance being used.
 * @returns - Transaction instance with the client being used and the query result.
 */
export async function execTrans(qry : QueryConfig, transInst : TransactionInstance) : Promise<TransactionInstance> {
    /* Pre conditional checking before adding the transaction to the current client */
    if(!transInst.client) 
        return {client : transInst.client, error: "Undefined client used in transaction"};
    if(transInst.error){
        if(transInst.client){
            transInst.client.query('ROLLBACK');
            transInst.client.release();
            return {error: "Transaction instance contains an error already. Transaction client has been released for safety"};
        }
        return {error: "Transaction instance contains an error already."};
    }

    /* Processing the transaction */
    try{
        const result : QueryResult = await transInst.client.query(qry);
        transInst.result = result;
        return transInst;
    }catch(err){
        console.log("[ERROR]: [TRANSACTION EXEC]: ", err);
        transInst.client.query('ROLLBACK');
        transInst.client.release();
        transInst.client = undefined;
        transInst.error = err;
        console.log("[DEBUG]: [TRANSACTION EXEC]: Client has been released");
        return transInst;
    }
};



/**
 * Call this function whenever you want to clear the instance and end the transaction (Commit it).
 * @param transInst - Holds the transaction instance.
 */
export async function endTrans(transInst : TransactionInstance) : Promise<void> {
    if(transInst.error){
        console.log("[ERROR]: [TRANSACTION END]: Transaction Instance contain an error!");
        if(transInst.client){
            await transInst.client.query('ROLLBACK');
            transInst.client.release();
            console.log("[DEBUG]: [TRANSACTION END]: Transaction client is released and transaction is rolled back");
        }
    }

    if(transInst.client){
        await transInst.client.query('COMMIT');
        transInst.client.release();
        console.log("[DEBUG]: [TRANSACTION END]: Transaction Committed Successfully!");
    }
};
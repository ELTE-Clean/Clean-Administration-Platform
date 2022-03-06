import {Pool} from "pg";

const pool = new Pool();    // Uses the environment variables to connect to the database

// const startTransaction = async (transaction : Number) => {
//     const client = await pool.connect();
//     try{
//         await client.query('BEGIN');
//     }catch(e){
//         console.log(e);
//     }finally{
//         client.release();
//     }
// };
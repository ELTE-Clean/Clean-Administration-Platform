/**
 * This module handles the logging of our backend. Logging can be configured in the .env file. 
 * 
 * 
 */

/* Each log level includes the one before it. 3 for instance include all 0,1,2,3*/
const LEVELS_TO_NUMBERS = new Map<string, number>([
    ["ERROR" , 0],
    ["WARNING" , 1],
    ["INFO" , 2],
    ["DEBUG" , 3]
])

/* The maximum log level to show. */
const MAX_LOG_LEVEL_NUMBER : number = LEVELS_TO_NUMBERS.get(process.env.LOG_LEVEL || 'INFO') || 2;


/**
 * 
 * @param level - A level
 * @returns 
 */
export function log(level: string, message: string) : void {
    if(!LEVELS_TO_NUMBERS.has(level))
        throw new Error("No such log level exists!");
    const log_num = (LEVELS_TO_NUMBERS.get(level) || 2);
    if(MAX_LOG_LEVEL_NUMBER < log_num)
        return;

    console.log("%s; [%s]; %s", new Date(), level, message);
};



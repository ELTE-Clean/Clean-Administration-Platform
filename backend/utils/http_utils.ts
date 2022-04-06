/** This module handles the utilities of fetching data with http. */
import axios from "axios";
import {Method} from "axios";


interface RequestResult {
    result: null | undefined | any, // The result of the request
    error: null | undefined | any   // The error if any are found
}


/**
 * Encapsulates our http fetching method. call execReq whenever you want to execute an HTTP request using the
 *  axios package.
 * @param method - The method you want to use e.g: "POST", "GET"
 * @param url - The URL of the request
 * @param body - The body of the request. Referred to as Data as well
 * @param headers - The headers of the request.
 * @returns - an object which either holds the requested result from the url or an error.
 */
export async function execReq(method : string , url : string, body : any, headers : any | Record< string, string | number | boolean>) : Promise<RequestResult>{
    let ret : RequestResult = {} as RequestResult;
    try {
        ret.result = await axios({ 
            method : method as Method,
            url: url, 
            data: body,
            headers: headers
        });
        ret.error = null;
        return ret as RequestResult;
    }catch(error){
        return {error: error, result: null} as RequestResult;
    }
};
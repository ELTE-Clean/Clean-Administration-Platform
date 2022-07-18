import React from "react";
import { useEffect, useState } from "react";
import { HttpStatus } from "../enums/httpStatus";


export type DataFetched<T> = {
  data: T | null;
  loading: boolean;
  error: string | null;
  response: Response | null;
};

export default function useFetch<Res>({
  url,
  method,
  params = [],
  body,
}: {
  method: string;
  url: string;
  params?: string[];
  body?: Record<string, any>;
}){


  const [res, setRes] = useState<DataFetched<{res: Res}>>({
    data: null,
    loading: false,
    error: null,
    response: null,
  });

  const ROOT_PATH = "http://localhost:5000";

  const fetchCall = () => {
    
    const apiPath =`${ROOT_PATH}/${url}`
    const headers: any = {
      "Content-Type" : "application/json"
    };
    
    setRes((prev) => ({ ...prev, loading: true }));
    fetch(apiPath, {
      method: method,
      "mode" : "cors",
      "credentials" : "include",
      headers: headers,
      body: JSON.stringify(body),
    })
      .then(async (result) => {
        const json = await result.json();
        if (result.status === HttpStatus.NOT_FOUND) {
          setRes((prevRes) => ({ ...prevRes, error: json }));
          return;
        }
        setRes((prevRes) => ({
          ...prevRes,
          data: json,
          response: result,
        }));
      })
      .catch((e) => {
        setRes((prevRes) => ({ ...prevRes, error: e }));
      })
      .finally(() => {
        setRes((prevRes) => ({ ...prevRes, loading: false }));
      });
  };

  useEffect(() => {
    fetchCall();
  }, [url]);

  return [res.data, res.loading, res.error, res.response];
}


export const fetchCall = async ({
  url,
  method,
  params = [],
  data,
  body,
}: {
  method: string;
  url: string;
  params?: string[];
  data?: Record<string, any>;
  body?: Record<string, any>;
}) => {

  const ROOT_PATH = "http://localhost:5000";

    
  const apiPath =`${ROOT_PATH}/${url}`
  const headers: any = {
    "Content-Type" : "application/json",
    "Access-Control-Allow-Methods": "DELETE"
  };
    
  return await fetch(apiPath, {
    "method": method,
    "mode" : "cors",
    "credentials" : "include",
    "headers": headers,
    "data" : data,
    "body": JSON.stringify(body),
  })
      
}
  
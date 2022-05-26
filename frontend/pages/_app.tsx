import "../styles/App.css";
import type { AppProps } from "next/app";
import Layout from "../components/layout";
import Head from "next/head";
import { useContext, useEffect, useState } from "react";
import { UserContext } from "../context/UserContext";
import { RequestType } from "../enums/requestTypes";
import useFetch, { fetchCall } from "../hooks/useFetch";
import { useRouter } from "next/router";

function MyApp({ Component, pageProps }: AppProps) {
  const [user, setUser] = useState({});
  const [sections, setSections] = useState([]);

  useEffect(() => {
    if (isUserLoggedIn()) {
      fetchCall({
        url: "users/self",
        method: RequestType.GET,
      })
        .then((response) => {
          const res = response.json();
          return res;
        })
        .then((data) => {
          setUser(data);
        })
        .catch((error) => {
          console.error(error);
        });
    }
  }, []);
  const isUserLoggedIn = () => {
    return localStorage.getItem("isLoggedIn") == "true";
  };

  // const value = useMemo(() => ({ user, setUser }), [user, setUser]);
  return (
    <>
      <UserContext.Provider value={{ user, setUser, sections, setSections }}>
        <Layout>
          <Head>
            <link rel="shortcut icon" href="/cleanLogo.png" />
          </Head>
          <Component {...pageProps} />
        </Layout>
      </UserContext.Provider>
    </>
  );
}

export default MyApp;

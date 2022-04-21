import "../styles/App.css";
import type { AppProps } from "next/app";
import Layout from "../components/layout";
import Head from "next/head";
import { useRouter } from "next/router";
import { useMemo, useState } from "react";
import { UserContext } from "../context/UserContext";

function MyApp({ Component, pageProps }: AppProps) {
  const [user, setUser] = useState(null);

  const value = useMemo(() => ({ user, setUser }), [user, setUser]);
  return (
    <>
      <UserContext.Provider value={value}>
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

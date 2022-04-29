import type { NextPage } from "next";
import { useRouter } from "next/router";
import { useContext } from "react";
import withAuth from "../components/withAuth";
import { UserContext } from "../context/UserContext";

const Home: NextPage = () => {
  const router = useRouter();
  const { user } = useContext(UserContext);

  return <div></div>;
};

export default withAuth(Home);

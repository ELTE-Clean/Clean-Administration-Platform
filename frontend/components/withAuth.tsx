import { useRouter } from "next/router";
import { UserContext } from "../context/UserContext";
import { useContext, useEffect } from "react";
import { RequestType } from "../enums/requestTypes";
import { fetchCall } from "../hooks/useFetch";

const withAuth = (Component) => {
  const AuthenticatedComponent = () => {
    const router = useRouter();
    const { user } = useContext(UserContext);

    const isUserLoggedIn = () => {
      if (typeof window !== "undefined") {
        return localStorage.getItem("isLoggedIn") == "true";
      }
    };
    useEffect(() => {
      if (typeof window !== "undefined") {
        if (!isUserLoggedIn() && router.asPath !== "/login") {
          router.push("/login");
        }

        if (isUserLoggedIn() && router.asPath == "/login") {
          router.push("/profile");
        }
      }
    }, []);

    const renderCondition =
      (isUserLoggedIn() && router.asPath !== "/login") ||
      (!isUserLoggedIn() && router.asPath === "/login");

    return renderCondition ? <Component /> : null;
  };

  return AuthenticatedComponent;
};

export default withAuth;

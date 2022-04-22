/* eslint-disable react-hooks/rules-of-hooks */
/* eslint-disable jsx-a11y/alt-text */
import type { NextPage } from "next";
import Image from "next/image";
import { useRouter } from "next/router";
import { useContext, useState } from "react";
import withAuth from "../components/withAuth";
import { UserContext } from "../context/UserContext";
import { RequestType } from "../enums/requestTypes";
import { fetchCall } from "../hooks/useFetch";

const Login: NextPage = () => {
  const { user, setUser } = useContext(UserContext);
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const router = useRouter();
  console.log("Login");

  let loginHandler = (e: any) => {
    e.preventDefault();

    fetchCall({
      url: "login",
      method: RequestType.POST,
      body: { username: username, password: password },
    })
      .then((response) => {
        const res = response.json();
        return res;
      })
      .then((data) => {
        if (data["response"] !== undefined) {
          console.log("Logged In:", data);
          localStorage.setItem("isLoggedIn", "true");
          router.push("/");
        } else {
          console.log("Permission Denied:", data);
        }
      })
      .catch((error) => {
        console.error(error);
      })
      .finally(() => {
        fetchCall({
          url: "users/get/self",
          method: RequestType.GET,
        })
          .then((response) => {
            const res = response.json();
            return res;
          })
          .then((data) => {
            setUser(data);
            console.log(user);
          })
          .catch((error) => {
            console.error(error);
          });
      });
  };

  return (
    <div className="login-container">
      <div className="bc-image-container">
        <Image
          src="/elte.jpg"
          objectFit="cover"
          layout="fill"
          priority={true}
        />
      </div>
      <div className="login-form-container">
        <form className="login-form">
          <div className="login-form-title">
            <h2>Login with your Neptun</h2>
          </div>
          <label>Neptun</label>
          <input
            type="text"
            placeholder="Write your neptun code..."
            value={username}
            onChange={(e) => setUsername(e.target.value)}
          />
          <label>Password</label>
          <input
            type="text"
            placeholder="Write your password..."
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
          <input
            id="login-btn"
            type="submit"
            value="Login"
            onClick={(e) => loginHandler(e)}
          />
        </form>
      </div>
    </div>
  );
};

export default withAuth(Login);

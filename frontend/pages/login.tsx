/* eslint-disable react-hooks/rules-of-hooks */
/* eslint-disable jsx-a11y/alt-text */
import type { NextPage } from "next";
import { route } from "next/dist/server/router";
import Image from "next/image";
import { useRouter } from "next/router";
import { useState } from "react";

// export const getStaticProps = async () => {
//   const res = await fetch("http://localhost:5003/api/v1/login");
//   const data = await res.json();
//   return {
//     props: { d: data },
//   };
// };

const Login: NextPage = ({ d }) => {
  // console.log(d);
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const router = useRouter();

  let loginHandler = (e: any) => {
    e.preventDefault();
    fetch("http://localhost:5000/login", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ username: username, password: password }),
    })
      .then((response) => {
        const res = response.json();
        return res;
      })
      .then((data) => {
        if (data["response"] !== undefined) {
          console.log("Logged In:", data);
          // router.push("/");
        } else {
          console.log("Permission Denied:", data);
        }
      })
      .catch((error) => {
        console.error("Error:", error);
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

export default Login;

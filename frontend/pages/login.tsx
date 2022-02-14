/* eslint-disable jsx-a11y/alt-text */
import type { NextPage } from "next";
import Image from "next/image";
const Login: NextPage = () => {
  let loginHandler = () => {};
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
          <input type="text" placeholder="Write your neptun code..." />
          <label>Password</label>
          <input type="text" placeholder="Write your password..." />
          <input
            id="login-btn"
            type="submit"
            value="Login"
            onClick={() => loginHandler()}
          />
        </form>
      </div>
    </div>
  );
};

export default Login;

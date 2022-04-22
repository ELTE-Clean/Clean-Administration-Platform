import type { NextPage } from "next";
import { useRouter } from "next/router";
import { useContext, useState } from "react";
import { UserContext } from "../context/UserContext";
import { RequestType } from "../enums/requestTypes";
import { fetchCall } from "../hooks/useFetch";
import withAuth from "../components/withAuth";

const Profile: NextPage = () => {
  const { user } = useContext(UserContext);
  const [showChangePassForm, setShowChangePassForm] = useState(false);
  const route = useRouter();
  console.log("pro");

  let handleLogOut = () => {
    fetchCall({
      url: "logout",
      method: RequestType.GET,
    })
      .then((response) => {
        const res = response.json();
        return res;
      })
      .then((data) => {
        localStorage.setItem("isLoggedIn", "false");

        route.push("/login");
      })
      .catch((error) => {
        console.error(error);
      });
  };

  let ChangePassForm = () => {
    let handelPassChange = () => {
      console.log("handling password change");
    };

    return (
      <div>
        <form action="" id="pass-change-form">
          <label>Old password</label>
          <br />
          <input type="text" placeholder="Write your old password " />
          <br />

          <label>New password</label>
          <br />
          <input type="text" placeholder="Write your new password " />
          <br />

          <label>Confirm new password</label>
          <br />
          <input type="text" placeholder="Confirm new password " />
          <div className="form-btns">
            <button id="change-btn" onClick={() => handelPassChange()}>
              Change
            </button>
            <button
              id="cancel-btn"
              onClick={() => setShowChangePassForm(false)}
            >
              Cancel
            </button>
          </div>
        </form>
      </div>
    );
  };

  return (
    <div className="profile-container">
      <div className="title">
        <h1>Profile</h1>
      </div>
      <div className="user-info">
        <p>
          Name:{" "}
          <b>
            {user["firstname"]} {user["lastname"]}
          </b>
        </p>
        <p>
          Neptun: <b> {user["username"]}</b>
        </p>
      </div>
      <div className="action-btns">
        <div className="change-pass-btn">
          {!showChangePassForm && (
            <button onClick={() => setShowChangePassForm(true)}>
              change password
            </button>
          )}
          {showChangePassForm && ChangePassForm()}
        </div>
        <div id="logout-btn">
          <button onClick={() => handleLogOut()}>Logout</button>
        </div>
      </div>
    </div>
  );
};

export default withAuth(Profile);

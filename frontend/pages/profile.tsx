import type { NextPage } from "next";
import Image from "next/image";
import { useState } from "react";

const Profile: NextPage = () => {
  const [showChangePassForm, setShowChangePassForm] = useState(false);
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
  let userName = "Abdulla Alkhulaqui";
  let neptun = "MI3JG2";
  return (
    <div className="profile-container">
      <div className="title">
        <h1>Profile</h1>
      </div>
      <div className="user-info">
        <p>
          Name: <b> {userName}</b>
        </p>
        <p>
          Neptun: <b> {neptun}</b>
        </p>
      </div>
      <div className="change-pass-btn">
        {!showChangePassForm && (
          <button onClick={() => setShowChangePassForm(true)}>
            change password
          </button>
        )}
        {showChangePassForm && ChangePassForm()}
      </div>
    </div>
  );
};

export default Profile;

import type { NextPage } from "next";
import { useRouter } from "next/router";
import { useContext, useEffect, useState } from "react";
import { UserContext } from "../context/UserContext";
import { RequestType } from "../enums/requestTypes";
import useFetch, { fetchCall } from "../hooks/useFetch";

const Profile: NextPage = () => {
  const { user } = useContext(UserContext);
  const [showChangePassForm, setShowChangePassForm] = useState(false);
  const [profile, setProfile] = useState({});
  const route = useRouter();
  const [data, loading, error] = useFetch<any>({
    method: RequestType.GET,
    url: "users/get/profile",
  });

  useEffect(() => {
    setProfile(data);
  }, [data, loading]);

  if (loading) {
    return <div>Loading...</div>;
  }
  if (!profile) {
    return <div>Error. No Profile info</div>;
  }

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
        route.push("/login");
      })
      .catch((error) => {
        console.error("Error:", error);
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
          Name:
          <b>
            {profile["firstname"]} {profile["lastname"]}
          </b>
        </p>
        <p>
          Neptun: <b> {profile["uid"]}</b>
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
      <div className="logout-btn">
        <button onClick={() => handleLogOut()}>Logout</button>
      </div>
    </div>
  );
};

export default Profile;

import RichTextEditor from "./RichTextEditor";
// import { useState } from "react";
import { useContext, useState } from "react";
import { RequestType } from "../enums/requestTypes";
import useFetch, { fetchCall } from "../hooks/useFetch";
const AddRemoveStudent = (props: any) => {
  const [studentNeptun, setStudentNeptun] = useState("");
  const [adminChoice, setAdminChoice] = useState("");
  const [users, setUsers] = useFetch({ url: "users", method: RequestType.GET});














  let addStudentHandler = (userData) => {
    if (studentNeptun.trim() == "") {
      alert("Input cannot be empty!!");
    } else {
      fetchCall({
        url: "groups/assign",
        method: RequestType.PUT,
        body: { userID: userData["uid"], groupID: 1 },
      })
        .then((response) => {
          const res = response.json();
          return res;
        })
        .catch((error) => {
          console.error(error);
        });
    }
  };

  let removeStudentHandler = (userData) => {
    if (studentNeptun.trim() == "") {
      alert("Input cannot be empty!!");
    } else {
      console.log(studentNeptun);
      fetchCall({
        url: "groups/unassign",
        method: RequestType.DELETE,
        body: { userID: userData["uid"], groupID: 1 },
      })
        .then((response) => {
          const res = response.json();
          return res;
        })
        .catch((error) => {
          console.error(error);
        });
    }
  };



  const getUsers = () => {
    fetchCall({
      url: "users",
      method: RequestType.GET,
    })
      .then((response) => {
        const res = response.json();
        return res;
      })
      .then((data) => {
        setUsers(data);
        console.log(data);
      })
      .catch((error) => {
        console.error(error);
      });
  };


  let searchUser = () =>{
    // console.log(users);
    let userData = null;
    users.forEach(element => {
      if (element["neptun"] == studentNeptun ){
        // console.log(element);
        userData = element;
      } 
    });
    return userData;
  };

  let submitHandler = () => {
    let userData = searchUser();
    console.log(userData);
    if ( userData != null){
    console.log(adminChoice);
    if (adminChoice == "Add") {
      addStudentHandler(userData);
    } else if (adminChoice == "Remove") {
      removeStudentHandler(userData);
    } else {
      console.log("Please choose to add or remove");
    }
  }else{
    console.log("Neptun ID was not found!");
  }
  };

  return (
    <div className="AddTemoveStudent-container">
      <div className={"admin-forms-holder"}>
        <form>
          <div className="container">
            <h1>Add / Remove user in a group</h1>
            <br />
            {/* <p>Make sure neptun codes are seperated by new lines</p> */}
            <br />
            <div className="Radios-area">
              <label className="Radio-container">
                Add
                <input
                  type="radio"
                  name="radio"
                  value="Add"
                  onChange={(e) => setAdminChoice(e.target.value)}
                />
                <span className="checkmark"></span>
              </label>
              <label className="Radio-container">
                Remove
                <input
                  type="radio"
                  name="radio"
                  value="Remove"
                  onChange={(e) => setAdminChoice(e.target.value)}
                />
                <span className="checkmark"></span>
              </label>
            </div>
            <br />

            <br />
            <label>User's Neptun code:</label>
            <br />
            <input
              type="text"
              placeholder="Write neptun code here..."
              name="addStudent"
              onChange={(e) => setStudentNeptun(e.target.value)}
              required
            />

            <div className="form-button">
              <button
                type="button"
                className="submitBtn"
                onClick={() => submitHandler()}
              >
                Apply
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  );
};

export default AddRemoveStudent;

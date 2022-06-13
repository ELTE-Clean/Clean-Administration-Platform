import RichTextEditor from "./RichTextEditor";
// import { useState } from "react";
import { useContext, useState } from "react";
import { RequestType } from "../enums/requestTypes";
import { fetchCall } from "../hooks/useFetch";
const AddRemoveStudent = (props: any) => {
  const [studentNeptun, setStudentNeptun] = useState("");
  const [adminChoice, setAdminChoice] = useState("");



  const getUsers = () => {
    fetchCall({
      url: "users/self",
      method: RequestType.GET,
    })
      .then((response) => {
        const res = response.json();
        return res;
      })
      .then((data) => {
        console.log(data);
      })
      .catch((error) => {
        console.error(error);
      });
  };







  let addStudentHandler = () => {
    if (studentNeptun.trim() == "") {
      alert("Input cannot be empty!!");
    } else {
      console.log(studentNeptun);
      fetchCall({
        url: "groups/assign",
        method: RequestType.PUT,
        body: { userID: studentNeptun, groupID: 1 },
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

  let removeStudentHandler = () => {
    if (studentNeptun.trim() == "") {
      alert("Input cannot be empty!!");
    } else {
      console.log(studentNeptun);
      fetchCall({
        url: "groups/unassign",
        method: RequestType.DELETE,
        body: { userID: studentNeptun, groupID: 1 },
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

  let submitHandler = () => {
    getUsers();
    console.log(adminChoice);
    if (adminChoice == "Add") {
      addStudentHandler();
    } else if (adminChoice == "Remove") {
      removeStudentHandler();
    } else {
      console.log("Please choose to add or remove");
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

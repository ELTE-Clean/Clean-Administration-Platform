import RichTextEditor from "./RichTextEditor";
// import { useState } from "react";
import { useContext, useState } from "react";
import { RequestType } from "../enums/requestTypes";
import { fetchCall } from "../hooks/useFetch";
const CreateStudentForm = (props: any) => {
  const [studentFirstName, setStudentFirstName] = useState("");
  const [studentLastName, setStudentLastName] = useState("");
  const [studentNeptun, setStudentNeptun] = useState("");

  let createStudentHandler = () => {
    const users = [
            {username: studentNeptun , 
             firstname: studentFirstName,
             lastname: studentLastName, 
             roles: ["student"],
             uid: studentNeptun},
         ] 
    console.log(studentFirstName);
    console.log(studentLastName);
    console.log(studentNeptun);
    if (studentFirstName.trim() == "" || studentLastName.trim() == "" || studentNeptun.trim() == "") {
      alert("Input cannot be empty!!");
    } else {
      fetchCall({
        url: "users/create",
        method: RequestType.POST,
        body: {users},
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

  return (
    <div className="AddTemoveStudent-container">
      <div className={"admin-forms-holder"}>
        <form>
          <div className="container">
            <h1>Create / Remove Student</h1>
            <br />
            <p>Make sure neptun codes are seperated by new lines</p>
            <br />
            <div className="Radios-area">
              <label className="Radio-container">
                Add
                <input type="radio" name="radio" />
                <span className="checkmark"></span>
              </label>
              <label className="Radio-container">
                Remove
                <input type="radio" name="radio" />
                <span className="checkmark"></span>
              </label>
            </div>
            <br />

            <br />
            <label>Student First Name:</label>
            <br />
            <input
              type="text"
              placeholder="Write Name here..."
              name="studentFirstName"
              onChange={(e) => setStudentFirstName(e.target.value)}
              required
            />

            <br />
            <label>Student Last Name:</label>
            <br />
            <input
              type="text"
              placeholder="Write Name here..."
              name="studentLastName"
              onChange={(e) => setStudentLastName(e.target.value)}
              required
            />

            
            <br />
            <label>Student Neptun Code:</label>
            <br />
            <input
              type="text"
              placeholder="Write Name here..."
              name="studentLastName"
              onChange={(e) => setStudentNeptun(e.target.value)}
              required
            />


            <div className="form-button">
              <button
                type="button"
                className="submitBtn"
                onClick={() => createStudentHandler()}
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

export default CreateStudentForm;

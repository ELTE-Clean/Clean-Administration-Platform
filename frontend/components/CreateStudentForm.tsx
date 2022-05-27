import RichTextEditor from "./RichTextEditor";
// import { useState } from "react";
import { useContext, useState } from "react";
import { RequestType } from "../enums/requestTypes";
import { fetchCall } from "../hooks/useFetch";
const CreateStudentForm = (props: any) => {
  const [studentFirstName, setStudentFirstName] = useState("");
  const [studentLastName, setStudentLastName] = useState("");
  const [studentNeptun, setStudentNeptun] = useState("");
  const [studentRole, setStudentRole] = useState("");
  const [adminChoice, setAdminChoice] = useState("");

  let createStudentHandler = () => {
    let studentRoleVar = studentRole.split(",");
    const users = [
            {username: studentNeptun , 
             firstname: studentFirstName,
             lastname: studentLastName, 
             roles: studentRoleVar,
             uid: studentNeptun},
         ] 
    console.log(studentFirstName);
    console.log(studentLastName);
    console.log(studentNeptun);
    console.log(studentRoleVar);
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



  let deleteStudentHandler = () => {
    const users = [{username: studentNeptun}] 
    if (studentNeptun.trim() == "") {
      alert("Input cannot be empty!!");
    } else {
      fetchCall({
        url: "users",
        method: RequestType.DELETE,
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


  let submitHandler = () =>{
    console.log(adminChoice);
    if (adminChoice == "Add"){
      createStudentHandler();
    }else if (adminChoice == "Remove"){
      deleteStudentHandler();
    }
    else {
      console.log("Please choose to add or remove")
    }
  }

  return (
    <div className="AddTemoveStudent-container">
      <div className={"admin-forms-holder"}>
        <form>
          <div className="container">
            <h1>Create / Remove User</h1>
            <br />
            <p>Make sure neptun codes are seperated by new lines</p>
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


      <br />
            <label>Student Role:(ex. student,demonstrator)</label>
            <br />
            <input
              type="text"
              placeholder="Write Name here..."
              name="studentLastName"
              onChange={(e) => setStudentRole(e.target.value)}
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

export default CreateStudentForm;
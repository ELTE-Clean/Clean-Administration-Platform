import RichTextEditor from "./RichTextEditor";
// import { useState } from "react";
import { useContext, useState } from "react";
import { RequestType } from "../enums/requestTypes";
import { fetchCall } from "../hooks/useFetch";
const AddRemoveStudent = (props: any) => {
  const [studentInput, setStudentInput] = useState("");

  let addStudentHandler = () => {
    if (studentInput.trim() == "") {
      alert("Input cannot be empty!!");
    } else {
      console.log(studentInput);
      fetchCall({
        url: "groups/assign",
        method: RequestType.PUT,
        body: { neptun: studentInput, groupID: 1 },
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
            <h1>Add / Remove Students</h1>
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
            <textarea
              name=""
              id="ADTextArea"
              cols={30}
              rows={10}
              onChange={(e) => setStudentInput(e.target.value)}
              placeholder="Paste neptun names..."
            ></textarea>
            {/* <RichTextEditor
              classTemp={"description-area"}
              valueTemp={"Enter neptun codes here... "}
            /> */}
            <div className="form-button">
              <button
                type="button"
                className="submitBtn"
                onClick={() => addStudentHandler()}
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

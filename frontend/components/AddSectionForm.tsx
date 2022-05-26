import router from "next/router";
import { useState } from "react";
import { RequestType } from "../enums/requestTypes";
import { fetchCall } from "../hooks/useFetch";

const AddSectionForm = ({
  addSectionCallBack,
  renderSectionsCB,
}: {
  addSectionCallBack: any;
}) => {
  const [userInput, setUserInput] = useState("");
  let addSectionHandler = () => {
    if (userInput.trim() == "") {
      alert("Input cannot be empty!!");
    } else {
      let sectionAlreadyIncluded = addSectionCallBack(userInput);
      if (sectionAlreadyIncluded) {
        alert(`Section "${userInput}" already exist!!`);
      } else {
        fetchCall({
          url: "sections/create",
          method: RequestType.POST,
          body: { sectionname: userInput, groupid: 1 },
        })
          .then((response) => {
            const res = response.json();
            return res;
          })
          .then((data) => {
            console.log("Added section", data);
            renderSectionsCB();
          })
          .catch((error) => {
            console.error(error);
          });
      }
    }
  };

  return (
    <div className="container">
      <h1>Add Section</h1>
      <br />
      <p>Make sure all sections have unique names!</p>
      <br />
      <label>Section Name:</label>
      <br />
      <input
        type="text"
        placeholder="Write Name here..."
        name="addSection"
        onChange={(e) => setUserInput(e.target.value)}
        required
      />
      <div className="form-button">
        <button
          type="button"
          className="submitBtn"
          onClick={() => addSectionHandler()}
        >
          Add
        </button>
      </div>
    </div>
  );
};

export default AddSectionForm;

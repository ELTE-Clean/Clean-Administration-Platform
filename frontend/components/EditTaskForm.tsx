import {
  BaseSyntheticEvent,
  ReactChild,
  ReactFragment,
  ReactPortal,
  useState,
} from "react";
import internal from "stream";
import EditTestCasesForm from "./EditTestCasesForm";
import RichTextEditor from "./RichTextEditor";
import PopUp from "./Popup";

const EditTaskForm = (props: any) => {
  const [taskName, setTaskName] = useState(props.task.title);
  const [taskDescription, setTaskDescription] = useState(
    props.task.description
  );
  const [functionName, setFunctionName] = useState("");
  const [uploadedFileName, setUploadedFileName] = useState("");
  const [buttonEditPopup, setButtonEditPopup] = useState(false);

  let handelFileUpload = (e: BaseSyntheticEvent) => {
    let latestFile = e.target.files[0].name;
    setUploadedFileName(latestFile);

    // later send file to the server
  };

  let uploadedSubmitBtnStyle = {
    backgroundColor: "#acf19b",
  };

  let uploadedBtnStyle = {
    border: "3px solid #acf19b",
    color: "#acf19b",
  };

  let funcViewHandler = (taskIndex: number) => {
    console.log("Handling viewing");
  };

  let removeFuncHandler = (taskIndex: number) => {
    console.log(`removing This function data`);
  };

  let addFuncHandler = () => {
    if (functionName.trim() === "") {
      alert("Function name should not be empty!!");
    } else {
      console.log("Adding function");
    }
  };

  let saveHandler = () => {
    if (taskName === "") {
      alert("Task name cannot be empty!!!");
    } else {
      console.log("Handling task name change");
    }
  };

  return (
    <div className="container">
      <h1>Edit {taskName}</h1>
      <br />
      <div className="two-section-container">
        <div className="left-section">
          <br />
          <h3>Name:</h3>
          <input
            type="text"
            value={taskName}
            onChange={(e) => setTaskName(e.target.value.trim())}
          />
          <br />
          <br />
          <h3>Description:</h3>
          {/* <textarea
            className="description-area"
            name="description"
            value={taskDescription}
            onChange={(e) => setTaskDescription(e.target.value.trim())}
          /> */}
          <RichTextEditor classTemp={"description-area"} valueTemp={taskDescription}/>

          <br />
          <br />

          <h3>Attach files:</h3>
          {props.task.attachedFiles === null ? (
            ""
          ) : (
            <div className="edit-this-hw-task-attachments">
              {props.task.attachedFiles.map(
                (attachedFile: string, idx: number) => (
                  <div key={idx} className="attachment">
                    <p>{attachedFile}</p>
                  </div>
                )
              )}
            </div>
          )}

          <div className="edit-homework-upload-area">
            <label
              htmlFor="file-upload"
              className="custom-file-upload"
              style={uploadedFileName === "" ? {} : { ...uploadedBtnStyle }}
            >
              Add file
            </label>
            <input id="file-upload" onChange={handelFileUpload} type="file" />
            <input
              type="text"
              name=""
              id="uploaded-file"
              placeholder="No file chosen"
              readOnly
              value={uploadedFileName}
            />
          </div>
        </div>
        {/* <div className="vertical"></div> */}
        <div className="right-section">
          <br />
          <h3>Test Case</h3>
          <br />
          <div className="edit-homework-container">
            {props.task.testCases.map((testCase: any, idx: number) => (
              <div key={idx} className="homework-task-container">
                <div
                  className="edit-homework-btn"
                  onClick={() => setButtonEditPopup(true)}
                >
                  {testCase.name}
                </div>
                <div
                  className="remove-task-btn"
                  onClick={() => removeFuncHandler(2)}
                >
                  &times;
                </div>

                <PopUp
                  trigger={buttonEditPopup}
                  setTrigger={setButtonEditPopup}
                  popupType="edit-this-homework"
                  component={<EditTestCasesForm testCaseData={testCase} />}
                />
              </div>
            ))}
          </div>

          <br />

          <h3>Add Function</h3>
          <input
            type="text"
            placeholder="Function name"
            onChange={(e) => setFunctionName(e.target.value)}
          />
          <br />
          <button
            type="button"
            className="add-task-btn"
            onClick={addFuncHandler}
          >
            Add
          </button>
          <br />
        </div>
      </div>

      <div className="form-button">
        <button
          type="button"
          className="submitBtn"
          onClick={() => saveHandler()}
        >
          Save
        </button>
      </div>
    </div>
  );
};

export default EditTaskForm;

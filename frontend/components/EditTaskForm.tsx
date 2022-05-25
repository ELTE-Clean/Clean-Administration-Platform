import { BaseSyntheticEvent, useState } from "react";
import EditTestCasesForm from "./EditTestCasesForm";
import RichTextEditor from "./RichTextEditor";
import PopUp from "./Popup";
import router from "next/router";
import { RequestType } from "../enums/requestTypes";
import { fetchCall } from "../hooks/useFetch";

const EditTaskForm = (props: any) => {
  const [taskName, setTaskName] = useState(props.task.title);
  const [testCase, setTestCase] = useState({});
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
  console.log(props.task);

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

  let popTestCase = (testCaseId: number) => {
    const testCase = props.task.testCases[testCaseId];
    setTestCase(testCase);
    setButtonEditPopup(true);
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
  let deleteTaskHandler = () => {
    // fetchCall({
    //   url: "tasks",
    //   method: RequestType.DELETE,
    //   body: [{ taskid: props.section["sectionname"], sectionid: 1 }],
    // })
    //   .then((response) => {
    //     const res = response.json();
    //     return res;
    //   })
    //   .then((data) => {
    //     console.log("Removed section", props.section["sectionname"]);
    //     router.push("/");
    //   })
    //   .catch((error) => {
    //     console.error(error);
    //   });
  };
  let saveHandler = () => {
    if (taskName === "") {
      alert("Task name cannot be empty!!!");
    } else {
      console.log("Handling task name change");
      console.log(props.task);

      fetchCall({
        url: "tasks/update",
        method: RequestType.PUT,
        body: { task: { taskid: props.taskid }, diff: { taskname: "HW222" } },
      })
        .then((response) => {
          const res = response.json();
          return res;
        })
        .then((data) => {
          console.log("Saved Task", taskName);
          router.push("/");
        })
        .catch((error) => {
          console.error(error);
        });
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

          <RichTextEditor
            classTemp={"description-area"}
            valueTemp={taskDescription}
          />

          <br />
          <br />

          <h3>Solution file:</h3>

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
                  onClick={() => popTestCase(idx)}
                >
                  {testCase.name}
                </div>
                <div
                  className="remove-task-btn"
                  onClick={() => removeFuncHandler(2)}
                >
                  &times;
                </div>
              </div>
            ))}
            <PopUp
              trigger={buttonEditPopup}
              setTrigger={setButtonEditPopup}
              popupType="edit-this-homework"
              component={<EditTestCasesForm testCaseData={testCase} />}
            />
            ;
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
          <button
            type="button"
            className="delete-task-btn"
            onClick={deleteTaskHandler}
          >
            Delete task
          </button>
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

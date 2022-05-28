import { BaseSyntheticEvent, useState } from "react";
import EditTestCasesForm from "./EditTestCasesForm";
import RichTextEditor from "./RichTextEditor";
import PopUp from "./Popup";
import router from "next/router";
import { RequestType } from "../enums/requestTypes";
import { fetchCall } from "../hooks/useFetch";
import FileUpload from "./FileUpload";

const EditTaskForm = (props: any) => {
  const [task, setTask] = useState({
    taskName: props.task["taskname"],
    description: props.task["description"],
    testCases: props.task["testcases"],
    solution: props.task["solution"],
    dutDate: props.task["dutDate"],
    dutTime: props.task["dutTime"],
  });
  const [taskName, setTaskName] = useState(props.task["taskname"]);
  const [testCase, setTestCase] = useState({});
  const [taskDescription, setTaskDescription] = useState(
    props.task["description"]
  );
  const [functionName, setFunctionName] = useState("");
  const [buttonEditPopup, setButtonEditPopup] = useState(false);

  let handelFileUpload = (file: File) => {
    let latestFile = file.name;
    console.log(latestFile);
    // setUploadedFileName(latestFile);
    // later send file to the server
  };

  let funcViewHandler = (taskIndex: number) => {
    console.log("Handling viewing");
  };

  let popTestCase = (testCaseId: number) => {
    const testCase = task["testCases"][testCaseId];
    setTestCase(testCase);
    setButtonEditPopup(true);
  };

  let removeFuncHandler = (taskIndex: number) => {
    let testCases = task["testCases"];
    testCases.splice(taskIndex, 1);
    setTask({ ...task, testCases: testCases });
  };

  let addFuncHandler = () => {
    const funcName = functionName.trim();
    if (funcName === "") {
      alert("Function name should not be empty!!");
    } else {
      console.log("Adding function");
      let newTestCasesSet;
      if (task["testCases"] !== undefined) {
        newTestCasesSet = [
          ...task["testCases"],
          { name: funcName, testList: [] },
        ];
      } else {
        newTestCasesSet = [{ name: funcName, testList: [] }];
      }
      setTask({ ...task, testCases: newTestCasesSet });
    }
  };
  let deleteTaskHandler = () => {
    fetchCall({
      url: "tasks",
      method: RequestType.DELETE,
      body: { taskID: props.task["taskid"] },
    })
      .then((response) => {
        const res = response.json();
        return res;
      })
      .then((data) => {
        console.log("Removed task", props.task["taskid"]);
        router.push("/");
      })
      .catch((error) => {
        console.error(error);
      });
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
        body: { task: { taskID: props.taskID }, diff: { taskname: "HW222" } },
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
      <h1>Edit - {taskName}</h1>
      <br />
      <div className="two-section-container">
        <div className="left-section">
          <br />
          <h3>Name:</h3>
          <input
            type="text"
            value={taskName}
            onChange={(e) => setTaskName(e.target.value)}
          />
          <br />
          <br />
          <h3>Description:</h3>
          <RichTextEditor
            classTemp={"description-area"}
            valueTemp={taskDescription}
            onChange={(value) => setTaskDescription(value)}
          />

          <br />
          <div className="dates-solution">
            <div>
              <h3>Due date</h3>
              <input type="date" />
            </div>
            <div>
              <h3>Due time</h3>
              <input type="time" />
            </div>
            <div>
              <h3>Solution file:</h3>
              <div className="edit-homework-upload-area">
                <FileUpload getCB={handelFileUpload} />
              </div>
            </div>
          </div>
        </div>

        <br />

        <div className="right-section">
          <h3>Test Case</h3>
          <br />
          {task["testCases"] === undefined && (
            <p>No test cases yet for this task</p>
          )}
          {task["testCases"] !== undefined && (
            <div className="edit-homework-container">
              {task["testCases"].map((testCase: any, idx: number) => (
                <div key={idx} className="homework-task-container">
                  <div
                    className="edit-homework-btn"
                    onClick={() => popTestCase(idx)}
                  >
                    {testCase.name}
                  </div>
                  <div
                    className="remove-task-btn"
                    onClick={() => removeFuncHandler(idx)}
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
          )}

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
        <button
          type="button"
          className="delete-task-btn"
          onClick={deleteTaskHandler}
        >
          Delete task
        </button>
      </div>
    </div>
  );
};

export default EditTaskForm;

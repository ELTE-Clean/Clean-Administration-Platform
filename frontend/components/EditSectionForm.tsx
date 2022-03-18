import { useState } from "react";
import { Task } from "../interfaces/teacherTask";
import EditHomeworkForm from "./EditHomeworkForm";
import PopUp from "./Popup";

const EditSectionForm = (props: { sectionName: any; tasks: any[] }) => {
  const [sectionName, setSectionName] = useState(props.sectionName);
  const [taskName, setTaskName] = useState("");
  const [buttonEditPopup, setButtonEditPopup] = useState(false);

  let taskViewHandler = (taskIndex: number) => {
    console.log(`viewing task ${props.tasks[taskIndex].title}`);
  };
  let removeTaskHandler = (taskIndex: number) => {
    console.log(`removing task ${props.tasks[taskIndex].title}`);
  };
  let addTaskHandler = () => {
    let allTasksName = props.tasks.map((task: Task) => task.title);

    let taskNameAlreadyExist = allTasksName.includes(taskName);
    if (taskNameAlreadyExist) {
      alert(`Task "${taskName}" already exist!!`);
    } else if (taskName.trim() === "") {
      alert(`Task name cannot be empty!!!`);
    } else {
      console.log("adding task...");
    }
  };
  let saveHandler = () => {
    if (sectionName.trim() == "") {
      alert("section name cannot be empty!!");
    } else {
      console.log(sectionName);
      console.log("saving..");
    }
  };
  return (
    <div className="container">
      <h1>Edit {sectionName}</h1>
      <br />
      <label>Name:</label>
      <br />
      <input
        type="text"
        value={sectionName}
        onChange={(e) => setSectionName(e.target.value.trim())}
      />
      <br />
      <br />
      <p>Tasks:</p>
      <br />
      <div className="edit-homework-container">
        {props.tasks.map((task: Task, idx: number) => (
          <div key={idx} className="homework-task-container">
            <div
              className="edit-homework-btn"
              onClick={() => setButtonEditPopup(true)}
            >
              {task.title}
            </div>
            <div
              className="remove-task-btn"
              onClick={() => removeTaskHandler(idx)}
            >
              &times;
            </div>
            <PopUp
                  trigger={buttonEditPopup}
                  setTrigger={setButtonEditPopup}
                  popupType="edit-this-homework-data"
                  component={<EditHomeworkForm taskData={task} />}
                />
          </div>
        ))}
      </div>
      <br />

      <p>Tasks Name:</p>
      <input
        type="text"
        placeholder="Write the name of your task"
        onChange={(e) => setTaskName(e.target.value)}
      />
      <br />
      <button
        type="button"
        className="add-task-btn"
        onClick={() => addTaskHandler()}
      >
        Add task
      </button>
      <br />

      <div className="form-button">
        <button type="button" className="submitBtn" onClick={saveHandler}>
          Save
        </button>
      </div>
    </div>
  );
};

export default EditSectionForm;

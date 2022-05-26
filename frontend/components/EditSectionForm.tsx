import router, { useRouter } from "next/router";
import { useState } from "react";
import { RequestType } from "../enums/requestTypes";
import { fetchCall } from "../hooks/useFetch";
import { Task } from "../interfaces/teacherTask";
import EditHomeworkForm from "./EditHomeworkForm";
import PopUp from "./Popup";

const EditSectionForm = (props: { section: any; tasks: any[] }) => {
  const [taskName, setTaskName] = useState("");
  const [sectionName, setSectionName] = useState(props.section["sectionname"]);
  const [tasks, setTasks] = useState(props.tasks);
  const [buttonEditPopup, setButtonEditPopup] = useState(false);
  const router = useRouter();

  let taskViewHandler = (taskIndex: number) => {
    console.log(`viewing task ${tasks[taskIndex].title}`);
  };
  let removeTaskHandler = (taskIndex: number) => {
    const newTasks = [...tasks];
    newTasks.splice(taskIndex, 1);
    setTasks(newTasks);
  };
  let addTaskHandler = () => {
    console.log();

    let allTasksName = props.tasks.map((task: Task) => task.taskname);
    let taskNameAlreadyExist = allTasksName.includes(taskName);
    if (taskNameAlreadyExist) {
      alert(`Task "${taskName}" already exist!!`);
    } else if (taskName.trim() === "") {
      alert(`Task name cannot be empty!!!`);
    } else {
      const newTasks = [...props.tasks];
      const newTask = {
        title: taskName,
        dueTime: "",
        dueDate: "",
        grade: null,
        gradeOutOf: null,
      };
      newTasks.push(newTask);
      setTasks(newTasks);
    }

    fetchCall({
      url: "tasks/create",
      method: RequestType.POST,
      body: {
        taskname: taskName,
        groupid: props.section["groupid"],
        sectionid: props.section["sectionid"],
      },
    })
      .then((response) => {
        const res = response.json();
        return res;
      })
      .then((data) => {
        console.log("Tasks:", data);
        setTasks(data);
      })
      .catch((error) => {
        console.error(error);
      });
  };

  let removeSectionHandler = () => {
    const sectionId = props.section.sectionid;

    fetchCall({
      url: "sections",
      method: RequestType.DELETE,
      body: { sectionid: sectionId },
    })
      .then((response) => {
        const res = response.json();
        return res;
      })
      .then((data) => {
        console.log("Removed section", props.section["sectionname"]);
        router.push("/");
      })
      .catch((error) => {
        console.error(error);
      });
  };

  // let saveHandler = () => {
  //   if (sectionName === "") {
  //     alert("section name cannot be empty!!");
  //   } else {
  //     console.log(props.section["sectionname"]);
  //     console.log("saving..");
  //   }
  // };
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
              {task.taskname}
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

            {buttonEditPopup && (
              <PopUp
                trigger={buttonEditPopup}
                setTrigger={setButtonEditPopup}
                popupType="edit-this-homework-data"
                component={<EditHomeworkForm taskData={task} />}
              />
            )}
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
        <button type="button" className="submitBtn">
          Save
        </button>
        <button
          type="button"
          className="remove-section-btn"
          onClick={() => removeSectionHandler()}
        >
          Remove section
        </button>
      </div>
    </div>
  );
};

export default EditSectionForm;

import router, { useRouter } from "next/router";
import React, { useState } from "react";
import { RequestType } from "../enums/requestTypes";
import { fetchCall } from "../hooks/useFetch";
import { Task } from "../interfaces/teacherTask";
import EditHomeworkForm from "./EditHomeworkForm";
import FileUpload from "./FileUpload";
import PopUp from "./Popup";
import RichTextEditor from "./RichTextEditor";

const EditSectionForm = (props: { section: any; tasks: any[] }) => {
  const [taskName, setTaskName] = useState("");
  const [sectionName, setSectionName] = useState(props.section["sectionname"]);
  const [tasks, setTasks] = useState(props.tasks);
  const [task, setTask] = useState({
    name: "",
    description: "d",
    dueDate: "",
    dueTime: "",
    maxGrade: "",
    solution: "",
  });

  const router = useRouter();

  let taskViewHandler = (taskIndex: number) => {
    console.log(`viewing task ${tasks[taskIndex].title}`);
  };
  let removeTaskHandler = (taskIndex: number) => {
    const newTasks = [...tasks];
    newTasks.splice(taskIndex, 1);
    setTasks(newTasks);
  };

  let handleFileUpload = (file: File) => {
    let latestFile = file.name;
    setTask({ ...task, solution: file });
    console.log(latestFile);
  };

  let addTaskHandler = () => {
    console.log(task);

    // let allTasksName = props.tasks.map((task: Task) => task.taskname);
    // let taskNameAlreadyExist = allTasksName.includes(taskName);
    // if (taskNameAlreadyExist) {
    //   alert(`Task "${taskName}" already exist!!`);
    // } else if (taskName.trim() === "") {
    //   alert(`Task name cannot be empty!!!`);
    // } else {
    //   const newTasks = [...props.tasks];
    //   const newTask = {
    //     title: taskName,
    //     dueTime: "",
    //     dueDate: "",
    //     grade: null,
    //     gradeOutOf: null,
    //   };
    //   newTasks.push(newTask);
    //   setTasks(newTasks);
    // }

    fetchCall({
      url: "tasks/create",
      method: RequestType.POST,
      body: {
        ...task,
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
        // setTasks(data);
      })
      .catch((error) => {
        console.error(error);
      });
  };

  let removeSectionHandler = () => {
    const sectionId = props.section.sectionid;
    console.log("hey", sectionId);

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
  <br />;

  // let saveHandler = () => {
  //   if (sectionName.trim() === "") {
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
      <h2>Change section name</h2>
      <br />
      <input
        type="text"
        value={sectionName}
        onChange={(e) => setSectionName(e.target.value)}
      />
      <br />
      <br />
      <h2>Create task</h2>
      <br />

      <div className="create-task-form">
        <div className="task-meta-data">
          <div className="field">
            <label>* Task name:</label>
            <br />
            <input
              type="text"
              placeholder="Write the task..."
              onChange={(e) => setTask({ ...task, name: e.target.value })}
            />
          </div>
          <div className="field">
            <label>Due date</label>
            <br />
            <input
              type="date"
              placeholder="Write the due date..."
              onChange={(e) => setTask({ ...task, dueDate: e.target.value })}
            />
          </div>
          <div className="field">
            <label>Due time</label>
            <br />
            <input
              type="time"
              placeholder="Write the due time..."
              onChange={(e) => setTask({ ...task, dueTime: e.target.value })}
            />
          </div>
          <div className="field">
            <label>Maximum grade:</label>
            <br />
            <input
              type="number"
              placeholder="Maximum grade for the task..."
              onChange={(e) => setTask({ ...task, maxGrade: e.target.value })}
            />
          </div>
          <div className="field">
            <label>Task solution:</label>
            <br />
            <FileUpload getCB={handleFileUpload} />
          </div>
        </div>
        <div className="desc-area">
          <div className="field">
            <label>Description:</label>
            <br />
            <br />
            <RichTextEditor
              classTemp={"description-area"}
              valueTemp={""}
              onChange={(value) => setTask({ ...task, description: value })}
            />
            <br />
          </div>
        </div>
        <button
          type="button"
          className="add-task-btn"
          onClick={() => addTaskHandler()}
        >
          Add task
        </button>
        <br />
      </div>

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

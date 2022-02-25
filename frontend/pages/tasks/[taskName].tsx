import { BaseSyntheticEvent, useState } from "react";
import EditTaskForm from "../../components/EditTaskForm";
import PopUp from "../../components/Popup";
const Task = (props: any) => {
  let isTeacher: Boolean = true;
  const [buttonEditPopup, setButtonEditPopup] = useState(false);
  let uploadedBtnStyle = {
    border: "3px solid #acf19b",
    color: "#acf19b",
  };
  let uploadedSubmitBtnStyle = {
    backgroundColor: "#acf19b",
  };
  const [uploadedFileName, setUploadedFileName] = useState("");

  let handelFileUpload = (e: BaseSyntheticEvent) => {
    let latestFile = e.target.files[0].name;
    setUploadedFileName(latestFile);

    // later send file to the server
  };

  return (
    <div className="task-container">
      <div className="task-title">
        <h1>{props.task.title}</h1>
      </div>
      <div className="task-info">
        <div className="availability">
          <p>Open</p>
        </div>
        <div className="deadline">
          <p>
            {props.task.dutDate} {props.task.dutTme}
          </p>
        </div>
        <div className="grade">
          {props.task.grade === null ? (
            <p>-/{props.task.gradeOutOf}</p>
          ) : (
            <p>
              {props.task.grade}/{props.task.gradeOutOf}pts
            </p>
          )}
        </div>
      </div>

      {isTeacher && (
        <div className="edit-btn-container">
          {" "}
          <button onClick={() => setButtonEditPopup(true)} className="edit-btn">
            Edit
          </button>
          <PopUp
            trigger={buttonEditPopup}
            setTrigger={setButtonEditPopup}
            popupType="edit-this-homework"
            component={<EditTaskForm task={props.task} />}
          />
        </div>
      )}

      {props.task.description === null ? (
        ""
      ) : (
        <div className="task-description">
          <div className="title">
            <h1>Description</h1>
          </div>
          <div className="description-body">
            <p>{props.task.description}</p>
          </div>
        </div>
      )}

      {props.task.attachedFiles === null ? (
        ""
      ) : (
        <div className="task-attachments">
          <div className="title">
            <h1>Attachments</h1>
          </div>
          {props.task.attachedFiles.map((attachedFile: string, idx: number) => (
            <div className="attachment" key={idx}>
              <p>{attachedFile}</p>
            </div>
          ))}
        </div>
      )}
      <div className="upload-area">
        <label
          htmlFor="file-upload"
          className="custom-file-upload"
          style={uploadedFileName === "" ? {} : { ...uploadedBtnStyle }}
        >
          Upload
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
        <div id="submit-btn">
          <button
            style={uploadedFileName === "" ? {} : { ...uploadedSubmitBtnStyle }}
          >
            submit
          </button>
        </div>
      </div>
    </div>
  );
};

export default Task;

export async function getStaticPaths() {
  const tasks = [
    {
      title: "HW1",
      dutTme: "11:59",
      dutDate: "2022-3-1",
      grade: null,
      gradeOutOf: 50,
    },
    {
      title: "HW2",
      dutTme: "11:59",
      dutDate: "2022-3-1",
      grade: null,
      gradeOutOf: 20,
    },
    {
      title: "HW3",
      dutTme: "11:59",
      dutDate: "2022-1-1",
      grade: 30,
      gradeOutOf: 30,
    },
  ];
  const tasksParams = tasks.map((task) => {
    return { params: { taskName: task.title } };
  });
  return {
    paths: tasksParams,
    fallback: false,
  };
}

export async function getStaticProps(context: { params: any }) {
  /**
   *
   * for now this variable wont be used, when the backend is ready, we can back an api call passed on the params.taskName.
   * After that we wont need the task variable.
   *
   */
  const { params } = context;

  const task = {
    title: "HW1",
    dutTme: "11:59",
    dutDate: "2022-3-1",
    grade: null,
    gradeOutOf: 50,
    description: "Please dont forget to upload the .icl file",
    attachedFiles: ["mi3jg2-20220320.icl", "mi3jg2-20220320.icl"],
  };

  return {
    props: {
      task: task,
    },
  };
}

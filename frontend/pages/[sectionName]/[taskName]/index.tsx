import { useRouter } from "next/router";
import { BaseSyntheticEvent, useState } from "react";
import EditTaskForm from "../../../components/EditTaskForm";
import PopUp from "../../../components/Popup";
import Image from "next/image";
import withAuth from "../../../components/withAuth";
import FileUpload from "../../../components/FileUpload";

const Task = () => {
  const router = useRouter();
  let { sectionName, taskName } = router.query;
  const [uploaded, setUploaded] = useState(false);
  const task = {
    taskid: 5,
    taskName: "HW1",
    dutTme: "11:59",
    dutDate: "2022-3-1",
    grade: null,
    max: 50,
    description: "Please dont forget to upload the .icl file",
    testCases: [
      { name: "test1", testList: ["[1,2,3]", "[1,2,3,4,5]"] },
      { name: "test2", testList: ["[1,2,3]", "[1,2,3,4,5]"] },
      { name: "test3", testList: ["[1,2,3]", "[1,2,3,4,5]"] },
    ],
  };
  let isTeacher: Boolean = true;
  const [buttonEditPopup, setButtonEditPopup] = useState(false);
  let uploadedBtnStyle = {
    border: "3px solid #acf19b",
    color: "#acf19b",
  };
  let uploadedSubmitBtnStyle = {
    backgroundColor: "#acf19b",
  };

  let handelFileUpload = (file: File) => {
    let latestFile = file.name;
    setUploaded(true);
    console.log(latestFile);

    // later send file to the server
  };

  let handleScriptRun = () => {
    console.log("Running script...");
  };

  return (
    <div className="task-container">
      <div className="run-script" onClick={() => handleScriptRun()}>
        <Image
          src="/robot.png"
          objectFit="cover"
          layout="fill"
          priority={true}
          alt={"script"}
        />
      </div>
      <div className="task-title">
        <h1>{taskName}</h1>
      </div>
      <div className="task-info">
        <div className="availability">
          <p>Open</p>
        </div>
        <div className="deadline">
          <p>
            {task.dutDate} {task.dutTme}
          </p>
        </div>
        <div className="grade">
          {task.grade === null ? (
            <p>-/{task.gradeOutOf}</p>
          ) : (
            <p>
              {task.grade}/{task.gradeOutOf}pts
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
            component={<EditTaskForm task={task} />}
          />
        </div>
      )}
      {task.description === null ? (
        ""
      ) : (
        <div className="task-description">
          <div className="title">
            <h1>Description</h1>
          </div>
          <div className="description-body">
            <p>{task.description}</p>
          </div>
        </div>
      )}
      {!isTeacher && (
        <div className="upload-area">
          <FileUpload getCB={handelFileUpload} />
          <div id="submit-btn">
            <button style={!uploaded ? {} : { ...uploadedSubmitBtnStyle }}>
              submit
            </button>
          </div>
        </div>
      )}
      {isTeacher && (
        <div className="submissions-area">
          <div id="submission">
            <p>Sub</p>
            <p>Sub</p>
            <p>Sub</p>
            <p>Sub</p>
            <p>Sub</p>
          </div>
        </div>
      )}
    </div>
  );
};

export default withAuth(Task);

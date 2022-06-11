import { useRouter } from "next/router";
import { BaseSyntheticEvent, useEffect, useState } from "react";
import EditTaskForm from "../../../components/EditTaskForm";
import PopUp from "../../../components/Popup";
import Image from "next/image";
import withAuth from "../../../components/withAuth";
import FileUpload from "../../../components/FileUpload";
import { RequestType } from "../../../enums/requestTypes";
import { fetchCall } from "../../../hooks/useFetch";

const Task = () => {
  const [uploaded, setUploaded] = useState(false);
  const [buttonEditPopup, setButtonEditPopup] = useState(false);
  const [task, setTask] = useState({});
  const [submissions, setSubmissions] = useState([]);
  const router = useRouter();
  let { sectionName, taskid } = router.query;

  let isTeacher: Boolean = true;
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

  useEffect(() => {
    let querystring = require("querystring");

    try {
      querystring = querystring.stringify({
        taskid: taskid,
        description: true,
        solution: true,
        testcases: true,
      });
    } catch (error) {
      querystring = "";
    }
    fetchCall({
      url: "tasks?" + querystring,
      method: RequestType.GET,
    })
      .then((response) => {
        const res = response.json();
        return res;
      })
      .then((data) => {
        setTask(data[0]);
      })
      .catch((error) => {
        console.error(error);
      });
    fetchCall({
      url: `tasks/${taskid}/submissions?submission=true`,
      method: RequestType.GET,
    })
      .then((response) => {
        const res = response.json();
        return res;
      })
      .then((data) => {
        console.log(data);
        setSubmissions(data);
      })
      .catch((error) => {
        console.error(error);
      });
  }, [taskid]);

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
        <h1>{task["taskname"]}</h1>
      </div>
      <div className="task-info">
        <div className="availability">
          <p>Open</p>
        </div>
        <div className="deadline">
          <p>
            {task["dueDate"]} {task["dueTime"]}
          </p>
        </div>
        <div className="grade">
          {task["grade"] !== undefined ? (
            <p>
              {task["grade"]}/{task["max"]}
            </p>
          ) : (
            <p>-/{task["max"]}</p>
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
      {task["description"] === null ? (
        ""
      ) : (
        <div className="task-description">
          <div className="title">
            <h1>Description</h1>
          </div>
          <div className="description-body">
            <p>{task["description"]}</p>
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
      {isTeacher && submissions.length > 0 && (
        <div className="submissions-area">
          <div className="title">
            <h1>Submissions</h1>
          </div>
          <div id="submissions">
            {submissions.map((submission, idx) => (
              <div key={idx}>
                <p>
                  Userid: {submission.userid} - Usergrade: {submission.grade}
                </p>
                <p>
                  solution: {submission.submission} - Usergrade:{" "}
                  {submission.grade}
                </p>
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  );
};

export default withAuth(Task);

import { useRouter } from "next/router";
import { BaseSyntheticEvent, useState } from "react";
import EditTaskForm from "../../../components/EditTaskForm";
import PopUp from "../../../components/Popup";
import Image from "next/image";
import withAuth from "../../../components/withAuth";
import { RequestType } from "../../../enums/requestTypes";
import { fetchCall } from "../../../hooks/useFetch";
const Task = () => {
  const router = useRouter();
  let { sectionName, taskName } = router.query;

  const task = {
    title: "HW1",
    dutTme: "11:59",
    dutDate: "2022-3-1",
    grade: null,
    gradeOutOf: 50,
    description: "Please dont forget to upload the .icl file",
    attachedFiles: ["mi3jg2-20220320.icl", "mi3jg2-20220320.icl"],
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
  const [uploadedFileName, setUploadedFileName] = useState("");

  let handelFileUpload = (e: BaseSyntheticEvent) => {
    let latestFile = e.target.files[0].name;
    setUploadedFileName(latestFile);

    // later send file to the server
  };

  let getNumb = (str) =>{
    var matches = str.match(/(\d+)/);
    if (matches){
      return matches[0];
    }else{
      return 1
    }
    // return (matches.length > 0)? matches[0]: 1 ;
  }

  let handleScriptRun = () => {
    console.log("Running script...");
    const taskNum = (getNumb(taskName));
    fetchCall({
      url: `tasks/${taskNum}/grade`,
      method: RequestType.POST,
    })
      .then((response) => {
        const res = response.json();
        return res;
      })
      .then((data) => {
        console.log(data.result);
      })
      .catch((error) => {
        console.error(error);
      });
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
      {task.attachedFiles === null ? (
        ""
      ) : (
        <div className="task-attachments">
          <div className="title">
            <h1>Attachments</h1>
          </div>
          {task.attachedFiles.map((attachedFile: string, idx: number) => (
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

export default withAuth(Task);

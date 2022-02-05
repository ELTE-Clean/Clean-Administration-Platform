import { BaseSyntheticEvent, useState } from "react";

const Task = () => {
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
  let task = {
    title: "HW1",
    dutTme: "11:59",
    dutDate: "2022-3-1",
    grade: null,
    gradeOutOf: 50,
    description: "Please dont forget to upload the .icl file",
    attachedFiles: ["mi3jg2-20220320.icl", "mi3jg2-20220320.icl"],
  };

  return (
    <div className="task-container">
      <div className="task-title">
        <h1>{task.title}</h1>
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
          {task.attachedFiles.map((attachedFile) => (
            <div className="attachment">
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

import { ChangeEvent, useState } from "react";

const EditHomeworkForm = (props) => {
  const [taskData, setTaskData] = useState(props.taskData);

  return (
    <div className="EditHomeworkFormContainer">
      <div className="test-name">
        <h1>{taskData.taskname}</h1>
      </div>
      <div className="edit-homework-data">
        <label>Name:</label>
        <br />
        <input
          type="text"
          name="name-of-hw"
          value={taskData.taskname}
          onChange={(e) => {
            setTaskData({ ...taskData, taskname: e.target.value });
          }}
        />
        <br />
        <br />
        <div className="edit-homework-info">
          <div className="info-chunk">
            <label>Due Date:</label>
            <br />
            <input
              type="date"
              value={taskData.dueDate}
              name="name-of-hw"
              onChange={(e) => {
                setTaskData({ ...taskData, dueDate: e.target.value });
              }}
            />
          </div>
          <div className="info-chunk">
            <label>Due Time:</label>
            <br />
            <input
              type="time"
              value={taskData.dueTime}
              name="name-of-hw"
              onChange={(e) => {
                setTaskData({ ...taskData, dueTime: e.target.value });
              }}
            />
          </div>
          <div className="info-chunk">
            <label>Grade:</label>
            <br />

            <input
              type="number"
              value={taskData.max}
              name="name-of-hw"
              onChange={(e) => {
                setTaskData({ ...taskData, max: e.target.value });
              }}
            />
          </div>
        </div>
      </div>
      <div className="save-changes">
        <button
          className="save-changes-btn"
          onClick={(e) => {
            e.preventDefault();
          }}
          type="button"
        >
          Save Changes
        </button>
      </div>
    </div>
  );
};

export default EditHomeworkForm;

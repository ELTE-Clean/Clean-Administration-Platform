import { useState } from "react";

const EditHomeworkForm = (props) => {
    const [taskData, setTaskData] = useState(props.taskData);
    return (
        <div className="EditHomeworkFormContainer">
            <div className="test-name">
                <h1>{taskData.title}</h1>
            </div>
            <div className="edit-homework-data">
                <label>Name:</label>
                <br />
                <input
                    type="text"
                    placeholder={taskData.title}
                    name="name-of-hw"
                    required
                />
                <br />
                <div className="edit-homework-info">
                    <div className="info-chunk">
                        <label>Due Date:</label>
                        <br />
                        <input
                            type="text"
                            placeholder={taskData.title}
                            name="name-of-hw"
                            required
                        />
                    </div>
                    <div className="info-chunk">
                        <label>Due Time:</label>
                        <br />
                        <input
                            type="text"
                            placeholder={taskData.title}
                            name="name-of-hw"
                            required
                        />
                    </div>
                    <div className="info-chunk">
                        <label>Grade:</label>
                        <br />
                        <input
                            type="text"
                            placeholder={taskData.title}
                            name="name-of-hw"
                            required
                        />
                    </div>
                </div>

            </div>
            <br />
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

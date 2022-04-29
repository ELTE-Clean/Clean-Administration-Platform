import RichTextEditor from "./RichTextEditor";

const AssignTeacher = (props: any) => {
    return (
        <div className="assign-teacher-container">
            <div className={"admin-forms-holder"}>
                <form>
                    <div className="container">
                        <h1>Assign Teacher to a group</h1>
                        <br />
                        <label>Teacher's Neptun:</label>
                        <br />
                        <input
                            type="text"
                            placeholder="Write Neptun here..."
                            name="addSection"
                            required
                        />
                        <div className="form-button">
                            <button
                                type="button"
                                className="submitBtn"
                            >
                                Assign
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    );
};

export default AssignTeacher;
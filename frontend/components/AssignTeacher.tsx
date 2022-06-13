import { RequestType } from "../enums/requestTypes";
import { fetchCall } from "../hooks/useFetch";
import RichTextEditor from "./RichTextEditor";

const AssignTeacher = (props: any) => {

    fetchCall({
        url: "users",
        method: RequestType.GET,
    }).then((response) => {
        const res = response.json();
        return res;
    })
    .then((data) => {
        console.log(data);
    })
    .catch((error) => {
        console.error(error);
    });

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
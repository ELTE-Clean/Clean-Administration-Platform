import RichTextEditor from "./RichTextEditor";

const AddTemoveStudent = (props: any) => {
    return props.trigger ? (
        <div className="AddTemoveStudent-container">
            <div className={"PopUp-holder"}>
                <form>
                    <div className="container">
                        <h1>Add / Remove Students</h1>
                        <br />
                        <p>Make sure neptun codes are seperated by new lines</p>
                        <br />
                        <div className="Radios-area">
                            <label className="Radio-container">Add
                                <input type="radio" name="radio" />
                                <span className="checkmark"></span>
                            </label>
                            <label className="Radio-container">Remove
                                <input type="radio" name="radio" />
                                <span className="checkmark"></span>
                            </label>
                        </div>
                        <br />

                        <br />
                        <RichTextEditor classTemp={"description-area"} valueTemp={"Enter neptun codes here... "} />
                        <div className="form-button">
                            <button
                                type="button"
                                className="submitBtn"
                            >
                                Apply
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    ) : (
        <div></div>
    );
};

export default AddTemoveStudent;
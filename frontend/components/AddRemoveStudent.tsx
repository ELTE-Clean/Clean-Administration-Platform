import RichTextEditor from "./RichTextEditor";

const AddRemoveStudent = (props: any) => {
  return (
    <div className="AddTemoveStudent-container">
      <div className={"admin-forms-holder"}>
        <form>
          <div className="container">
            <h1>Add / Remove Students</h1>
            <br />
            <p>Make sure neptun codes are seperated by new lines</p>
            <br />
            <div className="Radios-area">
              <label className="Radio-container">
                Add
                <input type="radio" name="radio" />
                <span className="checkmark"></span>
              </label>
              <label className="Radio-container">
                Remove
                <input type="radio" name="radio" />
                <span className="checkmark"></span>
              </label>
            </div>
            <br />

            <br />
            <textarea
              name=""
              id="ADTextArea"
              cols="30"
              rows="10"
              placeholder="Paste neptun names..."
            ></textarea>
            {/* <RichTextEditor
              classTemp={"description-area"}
              valueTemp={"Enter neptun codes here... "}
            /> */}
            <div className="form-button">
              <button type="button" className="submitBtn">
                Apply
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  );
};

export default AddRemoveStudent;

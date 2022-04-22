import { useState } from "react";

const AddGroup = (/*{
    addGroupCallBack,
  }: {
    addGroupCallBack: any;
  }*/) => {

    const [userInput, setUserInput] = useState("");
    // let addGroupHandler = () => {
    //     if (userInput.trim() == "") {
    //       alert("Input cannot be empty!!");
    //     } else {
    //       let groupAlreadyIncluded = addGroupCallBack(userInput);
    //       if (groupAlreadyIncluded) {
    //         alert(`Group "${userInput}" already exist!!`);
    //       } else {
    //         console.log("Adding group");
    //       }
    //     }
    //   };

    return (
        <div className="assign-teacher-container">
            <div className={"admin-forms-holder"}>
                <form>
                    <div className="container">
                        <h1>Add Group</h1>
                        <br />
                        <p>Make sure group's name is unique.</p>
                        <br />
                        <label>Group Name:</label>
                        <br />
                        <input
                            type="text"
                            placeholder="Write Name here..."
                            name="addGroup"
                            onChange={(e) => setUserInput(e.target.value)}
                            required
                        />
                        <div className="form-button">
                            <button
                                type="button"
                                className="submitBtn"
                                //onClick={() => addGroupHandler()}
                            >
                                Add
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    );
};

export default AddGroup;
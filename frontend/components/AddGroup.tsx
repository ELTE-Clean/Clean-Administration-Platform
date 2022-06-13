import { useState } from "react";
import { RequestType } from "../enums/requestTypes";
import { fetchCall } from "../hooks/useFetch";
import router, { useRouter } from "next/router";
const AddGroup = () => {
  const [userInput, setUserInput] = useState("");
  const router = useRouter();



  let addGroupHandler = () => {
    if (userInput.trim() == "") {
      alert("Input cannot be empty!!");
    } else {
      console.log(userInput);
      fetchCall({
        url: "groups/create",
        method: RequestType.POST,
        body: { groupName: userInput},
      })
        .then((response) => {
          const res = response.json();
          return res;
        })
        .then((data) => {
          console.log(data);
          
          router.push("/");
        })
        .catch((error) => {
          console.error(error);
        });
    }
  };

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
                onClick={() => addGroupHandler()}
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

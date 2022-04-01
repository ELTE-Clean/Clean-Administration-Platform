import { ReactChild, ReactFragment, ReactPortal, useState } from "react";

const EditTestCasesForm = (props: {
  testCaseData: {
    testList: any;
    name: boolean | ReactChild | ReactFragment | ReactPortal | null | undefined;
  };
}) => {
  const [testCases, setTestCases] = useState(props.testCaseData.testList);
  const [newTestCase, setNewTestCase] = useState("");
  console.log(testCases);

  let handleInputChange = (value: string, idx: number) => {
    let tempTestCases = [...testCases];
    tempTestCases[idx] = value;
    setTestCases(tempTestCases);
  };

  let handleRemoveTestCase = (idx: number) => {
    let tempTestCases = [...testCases];
    tempTestCases.splice(idx, 1);
    setTestCases(tempTestCases);
  };

  let handleAddingNewTestCase = () => {
    console.log(`Adding ${newTestCase}`);
    setTestCases([...testCases, newTestCase]);
    setNewTestCase("");
  };
  let handleSavingTestCase = () => {
    console.log("Handling saving test case");
  };
  return (
    <div className="TestCasesFormContainer">
      <div className="test-name">
        <h1>{props.testCaseData.name}</h1>
      </div>
      <div className="test-cases-lists">
        {testCases.map((test: any, idx: number) => (
          <div key={idx} className="test-case">
            <input
              type="text"
              onChange={(e) => handleInputChange(e.target.value, idx)}
              value={testCases[idx]}
            />
            <div
              className="remove-task-case"
              onClick={() => handleRemoveTestCase(idx)}
            >
              &times;
            </div>
          </div>
        ))}
      </div>
      <div className="add-test-case">
        <input
          type="text"
          placeholder="add test case"
          value={newTestCase}
          onChange={(e) => setNewTestCase(e.target.value)}
        />
        <button
          onClick={(e) => {
            e.preventDefault();
            handleAddingNewTestCase();
          }}
        >
          Add
        </button>
      </div>
      <div className="save-changes">
        <button
          className="save-changes-btn"
          onClick={(e) => {
            e.preventDefault();
            handleSavingTestCase();
          }}
          type="button"
        >
          Save Changes
        </button>
      </div>
    </div>
  );
};

export default EditTestCasesForm;

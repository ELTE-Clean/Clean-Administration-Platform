import { useContext, useEffect, useState } from "react";
import { Task } from "../../interfaces/userTask";
import EditSectionForm from "../../components/EditSectionForm";
import PopUp from "../../components/Popup";
import Link from "next/link";
import { useRouter } from "next/router";
import { UserContext } from "../../context/UserContext";
import withAuth from "../../components/withAuth";

// import AssignTeacher from "../../components/AssignTeacher";
import AddRemoveStudent from "../../components/AddRemoveStudent";
import { RequestType } from "../../enums/requestTypes";
import { fetchCall } from "../../hooks/useFetch";

const Section = () => {
  const { sections } = useContext(UserContext);
  const [buttonEditPopup, setButtonEditPopup] = useState(false);
  const [section, setSection] = useState({ sectionid: "" });
  const [tasks, setTasks] = useState([]);

  const router = useRouter();
  const name: string = router.query.sectionName;
  let isTeacher: Boolean = true;
  let isAdmin: Boolean = true;
  // const sectionDetails = sections.filter(
  //   (section: { sectionid: Number; sectionname: string; groupid: Number }) =>
  //     section["sectionname"] === name
  // );
  // setSection(sectionDetails);

  const sectionExist = (sectionName: string) => {
    const sectionNames = sections.map(
      (section: { sectionid: Number; sectionname: string; groupid: Number }) =>
        section.sectionname
    );
    return sectionNames.includes(sectionName);
  };

  let isTaskOpen = (dateStr: string) => {
    const currentDateObj = new Date();
    const passedDateObj = new Date(dateStr);
    return (
      currentDateObj.getTime() < passedDateObj.getTime() &&
      currentDateObj.getDate() <= passedDateObj.getDate() &&
      currentDateObj.getMonth() + 1 <= passedDateObj.getMonth() + 1 &&
      currentDateObj.getFullYear() <= passedDateObj.getFullYear()
    );
  };

  useEffect(() => {
    let querystring = require("querystring");
    let tempSection = sections.filter(
      (section: { sectionid: Number; sectionname: string; groupid: Number }) =>
        section["sectionname"] === name
    )[0];
    setSection(tempSection);

    try {
      querystring = querystring.stringify({
        sectionid: section["sectionid"],
        // groupid: section["groupid"],
        description: true,
        solution: true,
        testcases: true,
      });
    } catch (error) {
      querystring = "";
    }
    fetchCall({
      url: "tasks?" + querystring,
      method: RequestType.GET,
    })
      .then((response) => {
        const res = response.json();
        return res;
      })
      .then((data) => {
        // console.log(data);
        setTasks(data);
      })
      .catch((error) => {
        console.error(error);
      });
  }, [name, section, sections]);

  return isAdmin ? (
    <div className="section-container">
      <div className="section-name">
        <h1>{name}</h1>
      </div>
      <AddRemoveStudent popupType="add-remove-student" />

      {/* <AssignTeacher popupType="assign-teacher" /> */}
    </div>
  ) : (
    <div className="section-container">
      <div className="section-name">
        <h1>{name}</h1>
      </div>

      {isTeacher && (
        <div className="edit-btn-container">
          {" "}
          <button onClick={() => setButtonEditPopup(true)} className="edit-btn">
            Edit
          </button>
          <PopUp
            trigger={buttonEditPopup}
            setTrigger={setButtonEditPopup}
            popupType="edit-home-work"
            component={<EditSectionForm tasks={tasks} section={section} />}
          />
        </div>
      )}
      {tasks.map((task, idx) => (
        <Link key={idx} href={`/${name}/${task["taskid"]}`} passHref>
          <div key={idx} className="section-task">
            <div className="task-title">
              <h3>{task["taskname"]}</h3>
            </div>
            <div className="task-info">
              <div className="availability">
                {isTaskOpen(`${task["dueDate"]} ${task["dueTime"]}`) ? (
                  <p>Open</p>
                ) : task["dueDate"] === undefined ||
                  task["dueDate"] === null ? (
                  <p>No deadline</p>
                ) : (
                  <p>Closed</p>
                )}
              </div>
              <div className="deadline">
                <p>
                  {task["dueDate"]} {task["dueTime"]}
                </p>
              </div>
            </div>
          </div>
        </Link>
      ))}
    </div>
  );
};

export default withAuth(Section);

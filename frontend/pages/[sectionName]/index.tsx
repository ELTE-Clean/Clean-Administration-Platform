import { useContext, useEffect, useState } from "react";
import { Task } from "../../interfaces/userTask";
import EditSectionForm from "../../components/EditSectionForm";
import PopUp from "../../components/Popup";
import Link from "next/link";
import { useRouter } from "next/router";
import { UserContext } from "../../context/UserContext";
import withAuth from "../../components/withAuth";

import AssignTeacher from "../../components/AssignTeacher";
import AddRemoveStudent from "../../components/AddRemoveStudent";
import { RequestType } from "../../enums/requestTypes";
import { fetchCall } from "../../hooks/useFetch";

const Section = () => {
  const { sections } = useContext(UserContext);
  const [buttonEditPopup, setButtonEditPopup] = useState(false);
  const [section, setSection] = useState({});
  const [tasks, setTasks] = useState([]);

  const router = useRouter();
  const name: string = router.query.sectionName;
  let isTeacher: Boolean = true;
  let isAdmin: Boolean = false;
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

  const getSectionIdGroupId = (sectionName: string) => {
    const sectionDetails = sections.filter(
      (section: { sectionid: Number; sectionname: string; groupid: Number }) =>
        section["sectionname"] === sectionName
    );

    return sectionDetails;
  };

  // useEffect(() => {
  //   console.log(sections);

  //   if (
  //     sections.message !== undefined &&
  //     typeof sections.message !== "string" &&
  //     Object.keys(sections).length > 0
  //   ) {
  //     if (!sectionExist(name)) {
  //       router.push("/custom404");
  //     }
  //   }
  // }, [sections]);

  // Here instead of "tasks" there should be an api call to the backend to get the respective data for sectionName

  useEffect(() => {
    // let s = sections.filter(
    //   (section: { sectionid: Number; sectionname: string; groupid: Number }) =>
    //     section["sectionname"] === name
    // )[0];
    // console.log(s);

    setSection(
      sections.filter(
        (section: {
          sectionid: Number;
          sectionname: string;
          groupid: Number;
        }) => section["sectionname"] === name
      )[0]
    );
    console.log(section);

    fetchCall({
      url: "tasks",
      method: RequestType.GET,
      data: {
        sectionid: section["sectionid"],
        groupid: section["groupid"],
      },
    })
      .then((response) => {
        const res = response.json();
        return res;
      })
      .then((data) => {
        setTasks(data);
      })
      .catch((error) => {
        console.error(error);
      });
  }, []);

  // const tasks = [
  //   {
  //     title: "HW1",
  //     dueTime: "11:59",
  //     dueDate: "2022-3-1",
  //     grade: null,
  //     gradeOutOf: 50,
  //   },
  //   {
  //     title: "HW2",
  //     dueTime: "11:59",
  //     dueDate: "2022-3-1",
  //     grade: null,
  //     gradeOutOf: 20,
  //   },
  //   {
  //     title: "HW3",
  //     dueTime: "11:59",
  //     dueDate: "2022-1-1",
  //     grade: 30,
  //     gradeOutOf: 30,
  //   },
  // ];

  //   let date = new Date();

  return isAdmin ? (
    <div className="section-container">
      <div className="section-name">
        <h1>{name}</h1>
      </div>
      <AddRemoveStudent popupType="add-remove-student" />

      <AssignTeacher popupType="assign-teacher" />
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
        <Link key={idx} href={`/${name}/${task["taskname"]}`} passHref>
          <div key={idx} className="section-task">
            <div className="task-title">
              <h3>{task["taskname"]}</h3>
            </div>
            <div className="task-info">
              <div className="availability">
                <p>Open</p>
              </div>
              <div className="deadline">
                <p>{/* {task.dueDate} {task.dueTime} */}2022-10-02 23:59</p>
              </div>
              <div className="grade">
                {task.grade === null ? (
                  // <p>-/{task.gradeOutOf}</p>
                  <p>-/{task["max"]}</p>
                ) : (
                  <p>
                    <p>-/{task["max"]}</p>
                  </p>
                )}
              </div>
            </div>
          </div>
        </Link>
      ))}
    </div>
  );
};

export default withAuth(Section);

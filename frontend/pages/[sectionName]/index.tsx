import { useState } from "react";
import { Task } from "../../interfaces/userTask";
import EditSectionForm from "../../components/EditSectionForm";
import PopUp from "../../components/Popup";
import Link from "next/link";
import { useRouter } from "next/router";
import AssignTeacher from "../../components/AssignTeacher";
import AddRemoveStudent from "../../components/AddRemoveStudent";
const Section = () => {
  const router = useRouter();
  let name = router.query.sectionName;

  let isTeacher: Boolean = true;
  let isAdmin: Boolean = true;
  // Here instead of "tasks" there should be an api call to the backend to get the respective data for sectionName
  const [buttonEditPopup, setButtonEditPopup] = useState(false);

  const tasks = [
    {
      title: "HW1",
      dueTime: "11:59",
      dueDate: "2022-3-1",
      grade: null,
      gradeOutOf: 50,
    },
    {
      title: "HW2",
      dueTime: "11:59",
      dueDate: "2022-3-1",
      grade: null,
      gradeOutOf: 20,
    },
    {
      title: "HW3",
      dueTime: "11:59",
      dueDate: "2022-1-1",
      grade: 30,
      gradeOutOf: 30,
    },
  ];

  //   let date = new Date();

  return isAdmin ? (
<div className="section-container">
      <div className="section-name">
        <h1>{name}</h1>
      </div>
      <AddRemoveStudent
        
        popupType="add-remove-student"
      />

      <AssignTeacher
       
        popupType="assign-teacher"
      />
    </div>
  ):(
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
            component={<EditSectionForm tasks={tasks} sectionName={name} />}
          />
        </div>
      )}

      {tasks.map((task, idx) => (
        <Link key={idx} href={`/${name}/${task.title}`} passHref>
          <div key={idx} className="section-task">
            <div className="task-title">
              <h3>{task.title}</h3>
            </div>
            <div className="task-info">
              <div className="availability">
                <p>Open</p>
              </div>
              <div className="deadline">
                <p>
                  {task.dueDate} {task.dueTime}
                </p>
              </div>
              <div className="grade">
                {task.grade === null ? (
                  <p>-/{task.gradeOutOf}</p>
                ) : (
                  <p>
                    {task.grade}/{task.gradeOutOf}
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

export default Section;

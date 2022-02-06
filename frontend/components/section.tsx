import { Task } from "../interfaces/task";

const Section = (sectionName: String) => {
  let name = "Homeworks";
  let isTeacher: Boolean = true;
  // Here instead of "tasks" there should be an api call to the backend to get the respective data for sectionName

  const tasks = [
    {
      title: "HW1",
      dutTme: "11:59",
      dutDate: "2022-3-1",
      grade: null,
      gradeOutOf: 50,
    },
    {
      title: "HW2",
      dutTme: "11:59",
      dutDate: "2022-3-1",
      grade: null,
      gradeOutOf: 20,
    },
    {
      title: "HW2",
      dutTme: "11:59",
      dutDate: "2022-1-1",
      grade: 30,
      gradeOutOf: 30,
    },
  ];

  //   let date = new Date();

  return (
    <div className="section-container">
      {/* <div className="section-name">{sectionName}</div> */}
      <div className="section-name">
        <h1>Homeworks</h1>
      </div>
      {isTeacher && <button>Edit</button>}

      {tasks.map((task, idx) => (
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
                {task.dutDate} {task.dutTme}
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
      ))}
    </div>
  );
};

export default Section;

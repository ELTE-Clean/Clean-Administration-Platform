const EditHomeworkForm = (props) => {
    return (
        
      <div className="container">
        
        <h1>Edit {props.name}</h1>
        <br/>
        <label>Name:</label>
        <br/>
        <input type="text" placeholder="Write home name here..." name="editHomework" required/>
        <br/>
        <p>Tasks:</p>
        <br/>
        <div className="edit-homework-container">
        {props.tasks.map((task, idx) => (
            <div  key={idx} className="edit-homework-btn">{task.title}</div>
        ))}
        
        
        </div>
        <br/>

        <p>Tasks Name:</p>
        <br/>
        <input type="text" placeholder="Write the name of your task" name="taskName" required/>
        <br/>
        <button className="add-task-btn">Add task</button>
        <br/>

        <div className="form-buttom">
            <button type="button" className="submitBtn">Save</button>
        </div>
  
      </div>
    );
  };
  
  export default EditHomeworkForm;
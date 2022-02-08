const AddSectionForm = () => {
  return (

    <div className="container">
      
      <h1>Add Section</h1>
      <br/>
      <p>Make sure all sections have unique names!</p>
      <br/>
      <label>Section Name:</label>
      <br/>
      <input type="text" placeholder="Write Name here..." name="addSection" required/>
      <div className="form-buttom">
          <button type="button" className="submitBtn">add</button>
      </div>

    </div>
  );
};

export default AddSectionForm;

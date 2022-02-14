const PopUp = (props) => {
  return props.trigger ? (
    <div className="popup-task-container">
      <div className="PopUp-holder">
        <form>
          <div className="exit-container">
            <span
              onClick={() => props.setTrigger(false)}
              className="close-btn"
              title="Close"
            >
              &times;
            </span>
          </div>
          {props.component}
        </form>
      </div>
    </div>
  ) : (
    ""
  );
};

export default PopUp;

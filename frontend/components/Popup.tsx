const PopUp = (props : any) => {
  return props.trigger ? (
    <div className="popup-task-container">
      <div className={ props.popupType === "edit-this-homwwork"?( "this-homework-popup-holder"): ("PopUp-holder")}>
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
    <div></div>
  );
};

export default PopUp;

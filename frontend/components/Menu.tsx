import Link from "next/link";
import Popup from './Popup'
import {useState} from 'react';
import Task from "./task";
import AddSectionForm from "./AddSectionForm";

const Menu = () => {
  let userNeptun = "MI3JG2";
  let sections = ["Homeworks", "Progress Tasks", "Mid Term", "End Term"];
  
  const [buttonAddSectionPopup, setButtonAddSectionPopup] = useState(false);
  
  return (
    <div className="menu-container">
      <Link href="/profile">
        <div className="profile-icon-neptun">
          <div className="profile-icon">{userNeptun.slice(0, 2)}</div>
          <div className="profile-neptun">{userNeptun}</div>
        </div>
      </Link>
      <div className="sections">
        {sections.map((sectionName, idx) => (
          <div key={idx} className="section">
            <div className="section-name">
              <h2>{sectionName}</h2>
            </div>
          </div>
        ))}
      </div>
      <div className="add-section-part">
      <div className="add-section-btn" onClick={()=> setButtonAddSectionPopup(true)}>Add Section</div>

      <Popup trigger={buttonAddSectionPopup} setTrigger={setButtonAddSectionPopup} popupType="add-section" component={<AddSectionForm />}/>

      </div>
    </div>
  );
};

export default Menu;

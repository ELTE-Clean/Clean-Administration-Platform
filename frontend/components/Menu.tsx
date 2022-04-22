import Link from "next/link";
import PopUp from "./Popup";
import { useState } from "react";
import AddSectionForm from "./AddSectionForm";

const Menu = () => {
  let userNeptun = "MI3JG2";
  let sections = ["Homeworks", "Progress Tasks", "Mid Term", "End Term"];
  let addSectionCallBack = (sectionToAdd: string) => {
    return sections.includes(sectionToAdd);
  };

  const [buttonAddSectionPopup, setButtonAddSectionPopup] = useState(false);

  return (
    <div className="menu-container">
      <Link href="/profile" passHref>
        <div className="profile-icon-neptun">
          <div className="profile-icon">{userNeptun.slice(0, 2)}</div>
          <div className="profile-neptun">{userNeptun}</div>
        </div>
      </Link>
      <div className="sections">
        {sections.map((sectionName, idx) => (
          <Link key={idx} href={`/${sectionName}`} passHref>
            <div className="section">
              <div className="section-name">
                <h2>{sectionName}</h2>
              </div>
            </div>
          </Link>
        ))}

        <Link href="/admin" passHref>
          <div className="section">
                <div className="section-name">
                  <h2>Admin Env.</h2>
                </div>
          </div>
        </Link>
      </div>
      <div className="add-section-part">
        <div
          className="add-section-btn"
          onClick={() => setButtonAddSectionPopup(true)}
        >
          Add Section
        </div>

        <PopUp
          trigger={buttonAddSectionPopup}
          setTrigger={setButtonAddSectionPopup}
          popupType="add-section"
          component={<AddSectionForm addSectionCallBack={addSectionCallBack} />}
        />
      </div>
    </div>
  );
};

export default Menu;

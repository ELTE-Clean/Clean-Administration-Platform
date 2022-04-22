import Link from "next/link";
import PopUp from "./Popup";
import { useState } from "react";
import AddSectionForm from "./AddSectionForm";

const Menu = () => {
  let userNeptun = "MI3JG2";
  let adminUser = "Admin"
  let sections = ["Homeworks", "Progress Tasks", "Mid Term", "End Term"];
  let groups = ["Group 1", "Group 2", "Group 3", "Group 4"];
  let isAdmin = true;
  let addSectionCallBack = (sectionToAdd: string) => {
    return sections.includes(sectionToAdd);
  };

  // let addGroupCallBack = (groupToAdd: string) => {
  //   return groups.includes(groupToAdd);
  // };

  const [buttonAddSectionPopup, setButtonAddSectionPopup] = useState(false);

  return isAdmin ? (
    <div className="menu-container">

      <div className="profile-icon-neptun">
        <div className="profile-icon">{adminUser.slice(0, 2)}</div>
        <div className="profile-neptun">{adminUser}</div>
      </div>

      <div className="sections">
        <Link href="/dashboard" passHref>
          <div className="section">
            <div className="section-name">
              <h2>Dashboard</h2>
            </div>
          </div>
        </Link>


        {groups.map((group, idx) => (
          <Link key={idx} href={`/${group}`} passHref>
            <div className="section">
              <div className="section-name">
                <h2>{group}</h2>
              </div>
            </div>
          </Link>
        ))}
      </div>


    </div>
  ) :
    (
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

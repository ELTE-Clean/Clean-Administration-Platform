import Link from "next/link";
import PopUp from "./Popup";
import { useContext, useEffect, useState } from "react";
import AddSectionForm from "./AddSectionForm";
import { UserContext } from "../context/UserContext";
import { RequestType } from "../enums/requestTypes";
import { fetchCall } from "../hooks/useFetch";

const Menu = () => {
  const { sections, setSections } = useContext(UserContext);
  const [buttonAddSectionPopup, setButtonAddSectionPopup] = useState(false);
  let userNeptun = "MI3JG2";
  // let sections = ["Homeworks", "Progress Tasks", "Mid Term", "End Term"];

  let addSectionCallBack = (sectionToAdd: string) => {
    return sections.message.includes(sectionToAdd);
  };
  const isUserLoggedIn = () => {
    return localStorage.getItem("isLoggedIn") == "true";
  };

  const renderSections = () => {
    fetchCall({
      url: "db/section/all",
      method: RequestType.GET,
    })
      .then((response) => {
        const res = response.json();
        return res;
      })
      .then((data) => {
        setSections(data);
      })
      .catch((error) => {
        console.error(error);
      });
  };

  useEffect(() => {
    if (isUserLoggedIn()) {
      renderSections();
    }
  }, []);

  if (typeof sections.message === "string" || sections.message === undefined) {
    return (
      <div>
        <p></p>
      </div>
    );
  }

  return (
    <div className="menu-container">
      <Link href="/profile" passHref>
        <div className="profile-icon-neptun">
          <div className="profile-icon">{userNeptun.slice(0, 2)}</div>
          <div className="profile-neptun">{userNeptun}</div>
        </div>
      </Link>
      <div className="sections">
        {sections.message.map((sectionName, idx) => (
          <Link key={idx} href={`/${sectionName.sectionid}`} passHref>
            <div className="section">
              <div className="section-name">
                <h2>{sectionName.sectionid}</h2>
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
          component={
            <AddSectionForm
              addSectionCallBack={addSectionCallBack}
              renderSectionsCB={renderSections}
            />
          }
        />
      </div>
    </div>
  );
};

export default Menu;

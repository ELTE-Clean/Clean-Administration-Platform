import Link from "next/link";
import PopUp from "./Popup";
import { useContext, useEffect, useState } from "react";
import AddSectionForm from "./AddSectionForm";
import { UserContext } from "../context/UserContext";
import { RequestType } from "../enums/requestTypes";
import { fetchCall } from "../hooks/useFetch";

const Menu = () => {
  const { sections, setSections } = useContext(UserContext);
  const [groups, setGroups] = useState([]);
  const [buttonAddSectionPopup, setButtonAddSectionPopup] = useState(false);
  let userNeptun = "MI3JG2";
  // let sections = ["Homeworks", "Progress Tasks", "Mid Term", "End Term"];

  let adminUser = "Admin";
  // let groups = ["Group 1", "Group 2", "Group 3", "Group 4"];
  let isAdmin = true;
  let addSectionCallBack = (sectionToAdd: string) => {
    return sections
      .map((section) => section["sectionname"])
      .includes(sectionToAdd);
  };
  const isUserLoggedIn = () => {
    return localStorage.getItem("isLoggedIn") == "true";
  };

  let addGroupCallBack = () => {
    return groups
      .map((group) => group["groupname"]);
  };


  const renderGroups = () => {
    console.log("Hello world!");
    fetchCall({
      url: "groups",
      method: RequestType.GET,
    })
      .then((response) => {
        const res = response.json();
        return res;
      })
      .then((data) => {
        let infor = data.results.map((res) => res["groupname"])
        setGroups(infor);
        console.log(infor);
      })
      .catch((error) => {
        console.error(error);
      });
  };




  const renderSections = () => {
    fetchCall({
      url: "sections",
      method: RequestType.GET,
    })
      .then((response) => {
        const res = response.json();
        return res;
      })
      .then((data) => {
        setSections(data);
        console.log(data);
      })
      .catch((error) => {
        console.error(error);
      });
  };

  useEffect(() => {
    if (isUserLoggedIn()) {
      renderSections(); 
      renderGroups();
    }

  }, []);

  if (sections.message !== undefined) {
    return (
      <div>
        <p></p>
      </div>
    );
  }


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
        
        {/* <Link href="/create_student" passHref>
          <div className="section">
            <div className="section-name">
              <h2>Create Student</h2>
            </div>
          </div>
        </Link> */}

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
  ) : (
    <div className="menu-container">
      <Link href="/profile" passHref>
        <div className="profile-icon-neptun">
          <div className="profile-icon">{userNeptun.slice(0, 2)}</div>
          <div className="profile-neptun">{userNeptun}</div>
        </div>
      </Link>
      <div className="sections">


        {sections.map((section, idx) => (

          <Link key={idx} href={`/${section.sectionname}`} passHref>
            <div className="section">
              <div className="section-name">
                <h2>{section.sectionname}</h2>
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
  );
};

export default Menu;

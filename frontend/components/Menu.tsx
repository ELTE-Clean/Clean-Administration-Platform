import Link from "next/link";
import PopUp from "./Popup";
import { useContext, useEffect, useState } from "react";
import AddSectionForm from "./AddSectionForm";
import { UserContext } from "../context/UserContext";
import { RequestType } from "../enums/requestTypes";
import { fetchCall } from "../hooks/useFetch";
import withAuth from "./withAuth";

const Menu = () => {
  const { sections, setSections } = useContext(UserContext);
  const { user } = useContext(UserContext);
  const [groups, setGroups] = useState([]);
  const [buttonAddSectionPopup, setButtonAddSectionPopup] = useState(false);
  // if (user["firstname"] === undefined) {
    //   return (
      //     <div>
      //       <p></p>
  //     </div>
  //   );
  // }
  
  const adminUser = user["firstname"];
  const userNeptun = "MI3JG2";
  const isAdmin = user["roles"]?.includes("admin");
  const isTeacher = user["roles"]?.includes("demonstrator");
  console.log(isAdmin,isTeacher);
  
  useEffect(() => {
    if (isUserLoggedIn()) {
      renderSections();
      renderGroups();
    }
  },[]);


  let addSectionCallBack = (sectionToAdd: string) => {
    return sections
      .map((section: { [x: string]: any; }) => section["sectionname"])
      .includes(sectionToAdd);
  };
  const isUserLoggedIn = () => {
    if (typeof window !== undefined){
      return localStorage.getItem("isLoggedIn") == "true";
    }
    return false
  };

  // let addGroupCallBack = () => {
  //   return groups.map((group) => group["groupname"]);
  // };
  console.log(isTeacher);
  

  const renderGroups = () => {
    fetchCall({
      url: "groups",
      method: RequestType.GET,
    })
      .then((response) => {
        const res = response.json();
        return res;
      })
      .then((data) => {
        let infor = data.results.map((res: { [x: string]: any; }) => res["groupname"]);
        setGroups(infor);
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
        // console.log(data);
      })
      .catch((error) => {
        console.error(error);
      });
  };

  return isAdmin ? (
    <div className="menu-container">
      <Link href="/profile" passHref>
        <div className="profile-icon-neptun">
          <div className="profile-icon">{adminUser.slice(0, 2)}</div>
          <div className="profile-neptun">{adminUser}</div>
        </div>
      </Link>

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
      {isTeacher && 
      <div className="add-section-part">
        <div
          className="add-section-btn"
          onClick={() => setButtonAddSectionPopup(true)}
        >
          Add Section
        </div>
      </div> && <PopUp
        trigger={buttonAddSectionPopup}
        setTrigger={setButtonAddSectionPopup}
        popupType="add-section"
        component={
          <AddSectionForm
            addSectionCallBack={addSectionCallBack}
            renderSectionsCB={renderSections}
          />
        }
      />}
    </div>
  );
};

export default withAuth(Menu);

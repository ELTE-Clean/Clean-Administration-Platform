import Link from "next/link";

const Menu = () => {
  let userNeptun = "MI3JG2";

  let sections = ["Homeworks", "Progress Tasks", "Mid Term", "End Term"];
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
    </div>
  );
};

export default Menu;

import type { NextPage } from "next";
import { useState } from "react";
import AddRemoveStudent from "../components/AddRemoveStudent";
import EditSectionForm from "../components/EditSectionForm";
import { useRouter } from "next/router";
// import AssignTeacher from "../components/AssignTeacher";
import AddGroup from "../components/AddGroup";

const dashboard: NextPage = () => {
  const router = useRouter();
  let name = router.query.sectionName;
  return (
    <div className="section-container">
      <div className="section-name">
        <h1>Dashboard</h1>
      </div>
      <AddGroup addGroupCallBack={undefined} />
    </div>

  );
};

export default dashboard;

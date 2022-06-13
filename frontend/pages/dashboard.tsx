import type { NextPage } from "next";
import { useState } from "react";
import AddRemoveStudent from "../components/AddRemoveStudent";
import EditSectionForm from "../components/EditSectionForm";
import { useRouter } from "next/router";
import Create_Student from "../components/CreateStudentForm";
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
      <Create_Student  />
    </div>

  );
};

export default dashboard
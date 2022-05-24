import type { NextPage } from "next";
import { useState } from "react";
import AddRemoveStudent from "../components/AddRemoveStudent";
import EditSectionForm from "../components/EditSectionForm";
import { useRouter } from "next/router";
import AssignTeacher from "../components/AssignTeacher";
import Create_Student from "../components/CreateStudentForm";

const createStudent: NextPage = () => {
  const router = useRouter();
  let name = router.query.sectionName;
  return (
    <div className="section-container">
      <div className="section-name">
        <h1>Create Student</h1>
      </div>
      <Create_Student  />
    </div>

  );
};

export default createStudent;
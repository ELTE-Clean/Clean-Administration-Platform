import type { NextPage } from "next";
import { useState } from "react";
import AddRemoveStudent from "../components/AddRemoveStudent";
import EditSectionForm from "../components/EditSectionForm";
import { useRouter } from "next/router";
import AssignTeacher from "../components/AssignTeacher";

const Admin: NextPage = () => {
  const router = useRouter();
  let name = router.query.sectionName;
  const tasks = [
    {
      title: "HW1",
      dueTime: "11:59",
      dueDate: "2022-3-1",
      grade: null,
      gradeOutOf: 50,
    },
    {
      title: "HW2",
      dueTime: "11:59",
      dueDate: "2022-3-1",
      grade: null,
      gradeOutOf: 20,
    },
    {
      title: "HW3",
      dueTime: "11:59",
      dueDate: "2022-1-1",
      grade: 30,
      gradeOutOf: 30,
    },
  ];
  return (
    <div className="section-container">
      <div className="section-name">
        <h1>Admin Enviroment</h1>
      </div>
      <AddRemoveStudent
        
        popupType="add-remove-student"
      />

      <AssignTeacher
       
        popupType="assign-teacher"
      />
    </div>

  );
};

export default Admin;

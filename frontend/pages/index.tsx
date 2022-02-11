import type { NextPage } from "next";
import Task from "../components/task";
import AddSectionForm from "../components/AddSectionForm";
import Section from "../components/section";

const Home: NextPage = () => {
  return (
    <div>
      {/* <Section sectionName="Homework" /> */}
      <Task />
      {/* <AddSectionForm /> */}
    </div>
  );
};

export default Home;

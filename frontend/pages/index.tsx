import type { NextPage } from "next";
import AddSectionForm from "../components/AddSectionForm";
import Section from "../components/section";
import Task from "../components/task";
const Home: NextPage = () => {
  return (
    <div>
      { <Section sectionName="Homework" />}
      {/* <Task /> */}
      {/*<AddSectionForm />*/}
    </div>
  );
};

export default Home;

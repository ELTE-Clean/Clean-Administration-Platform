import type { NextPage } from "next";
import withAuth from "../components/withAuth";
const Info: NextPage = () => {
  return (
    <div className="help-container">
      <p>Info page goes here</p>
    </div>
  );
};

export default withAuth(Info);

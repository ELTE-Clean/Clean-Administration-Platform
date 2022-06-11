import React, { useState } from "react";

const FileUpload = ({ getCB }: { getCB: any }) => {
  let uploadedBtnStyle = {
    border: "3px solid #acf19b",
    color: "#acf19b",
  };

  let uploadedSubmitBtnStyle = {
    backgroundColor: "#acf19b",
  };

  const sendFileBack = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files) {
      getCB(e.target.files[0]);
    }
  };
  return (
    <div className="FileUpload-container">
      <input
        type="file"
        className="custom-file-input"
        accept=".icl"
        onChange={(e) => sendFileBack(e)}
      />
    </div>
  );
};

export default FileUpload;

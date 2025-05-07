import { defineEventHandler } from "../../../util";

export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        "file_path": Date.now(),
        "file_name": "Utility_bill.pdf"
      }
    ],
  };
});
import { defineEventHandler } from "../../util";



let count = 0;
export default defineEventHandler(() => {
  count++;
  if (count > 3) {
    return {
      status: "success",
      code: "100000",
      message: "success",
      count,
      data: [{ kyc_status: "Verified" }],
    };
  }
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [{ kyc_status: "InReView" }],
  };
});

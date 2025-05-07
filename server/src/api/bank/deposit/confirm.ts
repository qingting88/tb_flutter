import { defineEventHandler } from "../../../util";

export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [],
  };
  //   return {
  //     status: "error",
  //     code: "260001",
  //     message: "Unable to trade.",
  //     errors: [
  //       {
  //         error_id: "a69a29d1-372f-4fdc-822e-e8184b2693b5",
  //       },
  //     ],
  //   };
});

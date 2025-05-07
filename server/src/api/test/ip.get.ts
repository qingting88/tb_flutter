import { defineEventHandler } from "../../util";




export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        ip: "12.34.56.78",
      },
    ],
  };
  // return {
  //   status: "error",
  //   code: "260001",
  //   message: "Unable to trade.",
  //   errors: [
  //     {
  //       error_id: "a69a29d1-372f-4fdc-822e-e8184b2693b5",
  //     },
  //   ],
  // };

  // return {
  //   status: "error",
  //   code: "210015",
  //   message: "The verification code was incorrect.",
  //   errors: [
  //     {
  //       error_id: "ac6307ce-cb15-4166-a909-3c36930dc072",
  //     },
  //   ],
  // };
});

import { defineEventHandler } from "../../../util";



export default defineEventHandler(() => {
  // return {
  //   status: "error",
  //   code: "230004",
  //   message: "Treasure Box currently does not support institutional users. We kindly ask for your understanding.",
  //   errors: [],
  // };
  return {
    status: "success",
    code: "110001",
    message: "verification code already sent, please check your email",
    data: [],
  };
  // return {
  //   status: "success",
  //   code: "100000",
  //   message: "success",
  //   data: [],
  // };
});

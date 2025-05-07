import { defineEventHandler } from "../../../util";



export default defineEventHandler(async (req) => {
  const body=req?.body
  if (body && body.code === "123456") {
    return {
      status: "success",
      code: "120000",
      message: "success",
      data: [
        {
          token: "3|GA76Zg184JIIwOihe1TQBs2RxVF9d68bojDtPWWG56ece243",
        },
      ],
    };
  }
  return {
    status: "error",
    code: "220001",
    message: "The verification code was incorrect.",
    errors: [],
  };
});

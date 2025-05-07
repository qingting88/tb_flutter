import { defineEventHandler } from "../../util";

export default defineEventHandler((req) => {
  console.log(req.body);
  if (req.body.password == "123456") {
    return {
      status: "success",
      code: "120000",
      message: "success",
      data: [
        {
          token: "6|WvaPNFfgn2T6GFHwhsJw9YOSbp99bk98eY52a0nQa717008c",
        },
      ],
    };
  } else {
    return {
      status: "error",
      code: "120001",
      message: "密码错误",
      errors: [],
    };
  }
});

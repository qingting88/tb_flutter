import { defineEventHandler } from "../../../../util";



export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        USD: [
          {
            timestamp: 1728387212,
            balance: 100,
          },
          {
            timestamp: 1728387900,
            balance: 200,
          },
        ],
      },
    ],
  };
});

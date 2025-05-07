import { defineEventHandler } from "../../../../util";

export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        success: true,
        message: "The new bank account has been added.",
        bank_id: "3b25e6c2-4043-4b06-b33e-cc07da95a7b8",
      },
    ],
  };
});

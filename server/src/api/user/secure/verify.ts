import { defineEventHandler } from "../../../util";

export default defineEventHandler(() => {
  return {
    status: "error",
    code: "210015",
    message: "The verification code not exist.",
    errors: [
      {
        error_id: "7d5c647a-8ab0-4dbb-88e0-7d50ff7bdf7a",
      },
    ],
  };
});

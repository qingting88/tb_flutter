import { defineEventHandler } from "../../../util";



export default defineEventHandler(() => {
  return {
    status: "success",
    code: "120000",
    message: "token updated",
    data: [
      {
        token: "84|xWLJKebV0VlubHzfp6Zy7KP2G99LA2BBVqftIUc931d63125",
      },
    ],
  };
});

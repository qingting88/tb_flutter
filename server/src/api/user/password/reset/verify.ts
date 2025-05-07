import { defineEventHandler } from "../../../../util";



export default defineEventHandler(() => {
  return {
    status: "success",
    code: "120000",
    message: "token updated",
    data: [
      {
        token: "61|iIyBk0kuiRPPR8RA54ffroiHuJX79TwCi4MCiqo73e57b92a",
        secure: {
          secure_setting: {
            two_factor: true,
            email_verify: true,
            phone_verify: true,
          },
          user_email: "qi***@flashwire.com",
          phone_country_code: "+1",
          phone_number: "408****2895",
        },
      },
    ],
  };
});

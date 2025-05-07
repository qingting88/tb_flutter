import { defineEventHandler } from "../../../util";



export default defineEventHandler(() => {
  return {
    status: "error",
    code: "230016",
    message: "The phone number is empty or not verified.",
    errors: [
      {
        error_id: "63e0677d-6e56-4070-b2c1-f61b3eb8a090",
      },
    ],
  };
  return {
    status: "success",
    code: "120001",
    message: "user action need verify",
    data: [
      {
        verify_uuid: "d25857e0-f7d9-4d96-84fe-59885397ab26",
        secure: {
          secure_setting: {
            two_factor: true,
            email_verify: true,
            phone_verify: false,
          },
          user_email: "qi***@flashwire.com",
          phone_country_code: "+1",
          phone_number: "408****2895",
        },
      },
    ],
  };
});

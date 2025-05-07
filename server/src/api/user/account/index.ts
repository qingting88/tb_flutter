import { defineEventHandler } from "../../../util";



export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        user: {
          name: "Yao i Ji",
          email: "ji***@gmail.com",
          status: "active",
          kyc_status: "Verified",
          last_login_at: "2024-06-24 03:20:20",
          phone_country_code: "",
          phone_number: "",
          extend: {
            secure_setting: {
              two_factor: false,
              email_verify: true,
              phone_verify: false,
            },
          },
        },
      },
    ],
  };
  // return {
  //   "status": "success",
  //   "code": "100000",
  //   "message": "success",
  //   "data": [
  //     {
  //       "user": {
  //         "name": "M M",
  //         "email": "ni***@gmail.com",
  //         "status": "active",
  //         "kyc_status": "Rejected",
  //         "last_login_at": "2024-06-24 08:23:29",
  //         "phone_country_code": "+86",
  //         "phone_number": "137****1270",
  //         "extend": {
  //           "secure_setting": {
  //             "two_factor": false,
  //             "email_verify": true,
  //             "phone_verify": true
  //           }
  //         }
  //       }
  //     }
  //   ]
  // }
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        user: {
          name: "wei qing ting",
          email: "qi***@flashwire.com",
          status: "active",
          // kyc_status: "Need update",
          // kyc_status: "In review",
          kyc_status: "Not verified",
          last_login_at: "2024-06-12 09:18:53",
          phone_country_code: "+86",
          phone_number: "185****0779",
          extend: {
            secure_setting: {
              two_factor: false,
              email_verify: true,
              phone_verify: true,
            },
          },
        },
      },
    ],
  };
});

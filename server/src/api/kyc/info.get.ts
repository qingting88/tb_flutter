import { defineEventHandler } from "../../util";

let uuid = "";
export default defineEventHandler((req) => {

  const query = req?.query
  if (query && query('verify_uuid')) {
    if (uuid === query('verify_uuid')) {
      return {
        status: "error",
        code: "11233344",
        message: "verify_uuid invidle",
        data: [],
      };
    }
    uuid = query('verify_uuid') as string;
    return {
      status: "success",
      code: "100000",
      message: "success",
      data: [
        {
          account_email: "jiyaoapp+39@gmail.com",
          first_name: "yao",
          middle_name: "yao",
          last_name: "Ji",
          country: "United States",
          address: "87686 18th St SE",
          city: "Bandon",
          state: "Alaska",
          zipcode: "97411-9234",
          birthdate: "1995-02-08",
          phone_country_code: "86",
          phone_country_code_short: "CN",
          phone_number: "13705141270",
          telegram: null,
          created_at: "2024-06-05 00:15:57",
          updated_at: "2024-06-05 01:01:59",
          ip: null,
          lang: null,
          address_line_2: null,
          registration_path: null,
          citizenship: "UNITED STATES",
        },
        // {
        //   account_email: "qingting.wei+test1@flashwire.com",
        //   first_name: "w",
        //   middle_name: "",
        //   last_name: "",
        //   country: "",
        //   address: "",
        //   city: "",
        //   state: "",
        //   zipcode: "",
        //   birthdate: "",
        //   phone_country_code: "",
        //   phone_number: "",
        //   phone_country_code_short: "",
        //   address_line_2: "",
        //   nationality: "",
        // },
      ],
    };
  }
  return {
    status: "success",
    code: "120001",
    message: "user action need verify",
    data: [
      {
        verify_uuid: Date.now(),
        secure: {
          secure_setting: {
            email_verify: true,
          },
          user_email: "qi***@flashwire.com",
          phone_country_code: "",
          phone_number: "",
        },
      },
    ],
  };
});

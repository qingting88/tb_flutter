import { defineEventHandler } from "../../util";

export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        list: [
          {
            uuid: "2715e759-c20d-41e4-b3a0-fe3a1290313a",
            name: "BTC wallet",
            currency: "BTC",
            address:
              "123cd2f6c44ewa32121316f3be324b2fd00c589c235f48b382061e33329c27ff777",
          },
        ],
        favorite_list: [
          {
            uuid: "2715e759-c20d-41e4-b3a0-fe3a1290313a",
            name: "BTC wallet",
            currency: "BTC",
            address:
              "123cd2f6c44ewa32121316f3be324b2fd00c589c235f48b382061e33329c27ff777",
          },
        ],
        recent_list: [
          {
            uuid: "2715e759-c20d-41e4-b3a0-fe3a1290313a",
            name: "BTC wallet",
            currency: "BTC",
            address:
              "123cd2f6c44ewa32121316f3be324b2fd00c589c235f48b382061e33329c27ff777",
          },
        ],
      },
    ],
  };
});

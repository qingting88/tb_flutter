import { defineEventHandler } from "../../util";

export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        amount_pay_to: "30",
        asset_pay_to: "USD",
        reference: "666",
      },
    ],
  };
});

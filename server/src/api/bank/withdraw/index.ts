import { defineEventHandler } from "../../../util";

export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        result: "success",
        message: "Your withdrawal request has been submitted successfully!",
        amount_pay_to: 200,
        asset_pay_to: "USD",
        reference: "fc6107bd-c2be-4ad2-abf3-c92ead7d5abb",
      },
    ],
  };
});

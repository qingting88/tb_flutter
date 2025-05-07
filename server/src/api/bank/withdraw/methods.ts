import { defineEventHandler } from "../../../util";

export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        type: "wire",
        title: "Wire Transfer",
        asset_fiat: "USD",
        fee: 30,
        fee_type: "flat",
        arrival: "Arrives within 1-2 Working days",
        arrival_time: "1-2 Working days",
        note: "",
      },
    ],
  };
});

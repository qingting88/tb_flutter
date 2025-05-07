import { defineEventHandler } from "../../../util";



export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        created: "2024-06-24T02:52:15.375487Z",
        quantity: 0.005,
        side: "sell",
        price: 62364.06,
        pair: "BTCUSD",
        processing_fee: "7.79",
        network_fee: 15.05,
        size: "288.97",
      },
    ],
  };
});

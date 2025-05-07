import { defineEventHandler } from "../../../util";

export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        created: "2024-06-07T01:21:06.393551Z",
        pair: "USDTUSD",
        price: 1.0102,
        quantity: 95.6048,
        processing_fee: "2.50",
        network_fee: 0.92,
        side: "sell",
        size: 100,
        base_coin: "USDT",
        quote_coin: "USD",
        fee_amount: 3.42,
        fee_asset: "USD",
      },
    ],
  };
});

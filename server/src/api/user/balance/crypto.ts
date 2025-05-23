import { defineEventHandler } from "../../../util";



export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        id: 1,
        user_id: 37,
        currency: "USDT",
        balance: 5799.02,
        sending: 0,
        receiving: 0,
        created_at: "2024-07-01T02:18:21.000000Z",
        updated_at: "2024-07-11T01:52:31.000000Z",
        full_name: "Tether",
        asset_type: "crypto",
        converted_currency: "USD",
        converted_balance: 5852.9508860000005,
      },
      {
        id: 4,
        user_id: 37,
        currency: "BTC",
        balance: 0.1961,
        sending: 0,
        receiving: 0,
        created_at: "2024-07-01T14:23:25.000000Z",
        updated_at: "2024-07-04T08:46:16.000000Z",
        full_name: "Bitcoin",
        asset_type: "crypto",
        converted_currency: "USD",
        converted_balance: 11972.391328,
      },
      {
        id: 5,
        user_id: 37,
        currency: "ETH",
        balance: 1.5039,
        sending: 0.03,
        receiving: 0,
        created_at: "2024-07-01T14:33:01.000000Z",
        updated_at: "2024-10-11T02:41:08.000000Z",
        full_name: "Ethereum",
        asset_type: "crypto",
        converted_currency: "USD",
        converted_balance: 3639.979404,
      },
      {
        id: 8,
        user_id: 37,
        currency: "USDC",
        balance: 1032.33,
        sending: 0,
        receiving: 0,
        created_at: "2024-07-02T03:23:02.000000Z",
        updated_at: "2024-07-04T08:43:56.000000Z",
        full_name: "USD Coin",
        asset_type: "crypto",
        converted_currency: "USD",
        converted_balance: 0,
      },
    ],
  };
});

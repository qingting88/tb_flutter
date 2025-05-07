import { defineEventHandler } from "../../../../util";

export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        BTC: {
          chains: [
            {
              name: "BTC",
              standard: "ERC-20",
              standard_display: "BTC-ERC20",
              deposit_confirmation_num: "32",
              est_deposit_arrival_time: "15 min",
              withdraw_fee: "0.0025",
            },
            {
              name: "BTC2",
              standard: "ERC-21",
              standard_display: "BTC-ERC21",
              deposit_confirmation_num: "20",
              est_deposit_arrival_time: "20 min",
              withdraw_fee: "0.0025",
            },
          ],
          minimum_deposit: "0.01",
          minimum_withdraw: "0.01",
          maximum_withdraw: "100",
          withdraw_limit_for_a_day: "200",
        },
      },
      {
        USDT: {
          chains: [
            {
              name: "ETH",
              standard: "ERC-20",
              standard_display: "BTC-ERC20",
              deposit_confirmation_num: "32",
              est_deposit_arrival_time: "15 min",
              withdraw_fee: "0.0025",
            },
          ],
          minimum_deposit: "0.01",
          minimum_withdraw: "0.01",
          maximum_withdraw: "100",
          withdraw_limit_for_a_day: "200",
        },
      },
      {
        USDC: {
          chains: [
            {
              name: "ETH",
              standard: "ERC-20",
              standard_display: "USDC-ERC20",
              deposit_confirmation_num: "32",
              est_deposit_arrival_time: "15 min",
              withdraw_fee: "0.0025",
            },
            {
              name: "BSC",
              standard: "BSC",
              standard_display: "USDC-BSC",
              deposit_confirmation_num: "32",
              est_deposit_arrival_time: "15 min",
              withdraw_fee: "0.0025",
            },
          ],
          minimum_deposit: "0.01",
          minimum_withdraw: "0.01",
          maximum_withdraw: "100",
          withdraw_limit_for_a_day: "200",
        },
      },
    ],
  };
});

// {
//   "code": 0,
//   "reason": "success",
//   "message": "succeed",
//   "request_id": "57933cc2-f650-4f46-a2e5-2496a2665144",
//   "data": [
//     {
//       "broker_id": 0,
//       "asset": "USDC",
//       "asset_name": "USD Coin",
//       "network": [
//         {
//           "id": 1003,
//           "name": "ERC20",
//           "disp_name": "USDC-ERC20",
//           "withdraw_fee": 0.3,
//           "minimum_withdraw": 0.3,
//           "deposit_confirm_num": 32,
//           "withdraw_confirm_num": 64,
//           "estimated_minutes": 17
//         },
//         {
//           "id": 1008,
//           "name": "BSC",
//           "disp_name": "BSC",
//           "withdraw_fee": 0.2,
//           "minimum_withdraw": 0.2,
//           "deposit_confirm_num": 11,
//           "withdraw_confirm_num": 15,
//           "estimated_minutes": 15
//         },
//         {
//           "id": 1009,
//           "name": "Polygon",
//           "disp_name": "Polygon",
//           "withdraw_fee": 1,
//           "minimum_withdraw": 2,
//           "deposit_confirm_num": 11,
//           "withdraw_confirm_num": 128,
//           "estimated_minutes": 11
//         },
//         {
//           "id": 1010,
//           "name": "ArbitrumOne",
//           "disp_name": "ArbitrumOne",
//           "withdraw_fee": 1,
//           "minimum_withdraw": 1,
//           "deposit_confirm_num": 11,
//           "withdraw_confirm_num": 100,
//           "estimated_minutes": 11
//         },
//         {
//           "id": 1011,
//           "name": "Optimism",
//           "disp_name": "Optimism",
//           "withdraw_fee": 1,
//           "minimum_withdraw": 1,
//           "deposit_confirm_num": 11,
//           "withdraw_confirm_num": 100,
//           "estimated_minutes": 11
//         }
//       ],
//       "decimal": 2,
//       "minimum_deposit": "5.00000000",
//       "maximum_deposit": "0.00000000",
//       "minimum_withdraw": "5.00000000",
//       "maximum_withdraw": "200.00000000",
//       "day_total_withdraw": "500.00000000",
//       "fee": "0.00100000",
//       "status": "On",
//       "created_at": "2023-02-13T07:11:55.000000Z",
//       "updated_at": "2024-04-02T09:17:01.000000Z"
//     }
//   ]
// }

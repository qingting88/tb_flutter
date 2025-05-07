

import Mock from "mockjs";
import { defineEventHandler } from "../../util";

export default defineEventHandler(() => {
  return Mock.mock({
    code: 10000,
    success: true,
    message: "OK",
    "data|20": [
      {
        transaction_uuid: "@guid()",
        asset_received: "USD",
        "amount_received|1-100.1-2": 1,
        asset_sent: "USD",
        "amount_sent|1-100.1-2": 1,
        category:
          '@pick(["wallet_received", "wallet_sent", "trade_buy", "trade_sell", "wire_in", "wire_out"])',
        created_at: "2024-09-11T02:10:31.000000Z",
      },
    ],
    pagination: {
      count: 20,
      per_page: 10,
      current_page: 1,
      last_page: 2,
    },
  });
});

// case WALLET_RECEIVED = 'wallet_received';
// case WALLET_SENT = 'wallet_sent';
// case TRADE_BUY = 'trade_buy';
// case TRADE_SELL = 'trade_sell';
// case WIRE_IN = 'wire_in';
// case WIRE_OUT = 'wire_out';
// case WIRE_RETURNED = 'returned';

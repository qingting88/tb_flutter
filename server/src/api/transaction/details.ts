import Mock from "mockjs";
import { defineEventHandler } from "../../util";

export default defineEventHandler(() => {
  return Mock.mock({
    code: 10000,
    success: true,
    message: "OK",
    data: [
      {
        transaction_uuid: "@guid()",
        from: "1324567890POLKJHGFDSADXCFGHJNBV",
        to: "USDC Wallet",
        fee_amount: 2.34,
        fee_asset: "USD",
        network: "ERC20",
        price: 0,
        asset_received: "USDC",
        amount_received: 20,
        asset_sent: "USDC",
        amount_sent: 123,
        category: '@pick(["wire_out"])',

        
        created_at: "2024-01-01T01:01:01Z",
        transaction_status: '@pick([ "Canceled"])',
        txid: "0x1231231",
        completed_at: "2024-01-01T01:01:01Z",
      },
    ],
  });
});
// category:
//           '@pick(["wallet_received", "wallet_sent", "trade_buy", "trade_sell", "wire_in", "wire_out"])',

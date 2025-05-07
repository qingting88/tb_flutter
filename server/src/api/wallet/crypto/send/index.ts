import { defineEventHandler } from "../../../../util";

export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        transaction_uuid: "T202407225ce740c6-b408-4f1f-a724-6ba10571e37c",
        amount: 0.0025,
        currency: "ETH",
        from: "My Crypto Wallet",
        to: "6ed6db51-c453-4b5d-8ce1-d7b951b92f59",
        network: "SEPOLIA_ETH",
        withdraw_fee: "0.000002100000336",
        order_date: "2024-07-22T21:56:12.000000Z",
      },
    ],
  };
});

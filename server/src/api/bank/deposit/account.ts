import { defineEventHandler } from "../../../util";

export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        deposit_account: {
          "Account Holder Name": "TreasureBox Inc",
          "Account Holder Address":
            "960 San Antonio Road, Suite 200, Palo Alto, CA 94303, United States",
          "Account Number": "1503983881",
          "Bank Name": "Signature Bank",
          "Bank Country": "United States",
          "Bank address": "565 Fifth Avenue New York NY 10017",
          "Bank SWIFT": "SIGNUS33XXX",
          "Routing Number / ABA Number": "026013576",
        },
        reference_code: "ZGAEIXS",
        asset_fiat: "USD",
        transfer_type: "wire",
      },
    ],
  };
});

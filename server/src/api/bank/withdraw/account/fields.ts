import { defineEventHandler } from "../../../../util";

export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        name: "account_name",
        label: "Account Holder Name",
        placeholder: "Enter the bank recipient name (your legal name)",
      },
      {
        name: "recipient_address",
        label: "Account Holder Address",
        placeholder: "Enter the bank recipient address",
      },
      {
        name: "bank_account_number",
        label: "Account Number",
        placeholder: "Enter account number",
      },
      {
        name: "bank_name",
        label: "Bank Name",
        placeholder: "Enter bank name",
      },
      {
        name: "bank_country",
        label: "Bank Country",
        placeholder: "Enter bank country",
      },
      {
        name: "bank_address",
        label: "Bank address",
        placeholder: "Enter bank address",
      },
      {
        name: "bank_swift",
        label: "Bank SWIFT",
        placeholder: "Bank SWIFT Code",
      },
      {
        name: "routing_number",
        label: "Routing Number / ABA Number",
        placeholder: "Routing Number / ABA Number",
      },
    ],
  };
});

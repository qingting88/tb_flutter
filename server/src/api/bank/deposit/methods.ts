import { defineEventHandler } from "../../../util";

export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        currency: "USD",
        currency_name: "US Dollar",
        currency_symbol: "$",
        transfer_types: {
          wire: {
            description: "Domestic wire transfer",
            arrival: "Arrives within 1-2 Working days",
            arrival_time: "1-2 Working days",
          },
          ach: {
            description: "ACH transfer",
            arrival: "Arrives within 2-3 Working days",
            arrival_time: "2-3 Working days",
          },
        },
      },
      {
        currency: "GBP",
        currency_name: "British pound sterling",
        currency_symbol: "£",
        transfer_types: {
          wire: {
            description: "FPS wire transfer",
            arrival: "Arrives within 10 Minutes- 1 Working day",
            arrival_time: "10 Minutes- 1 Working day",
          },
        },
      },
      {
        currency: "CHF",
        currency_name: "Swiss Franc ",
        currency_symbol: "CHF",
        transfer_types: {
          wire: {
            description: "SEPA transfer",
            arrival: "Arrives within 1 Working day",
            arrival_time: "1 Working day",
          },
        },
      },
      {
        currency: "EUR",
        currency_name: "Euro",
        currency_symbol: "€",
        transfer_types: {
          wire: {
            description: "SEPA transfer",
            arrival: "Arrives within 1-2 Working days",
            arrival_time: "1-2 Working days",
          },
        },
      },
      {
        currency: "JPY",
        currency_name: "Japanese Yen",
        currency_symbol: "¥",
        transfer_types: {
          wire: {
            description: "SWIFT Wire transfer",
            arrival: "Arrives within 1-3 Working days",
            arrival_time: "1-3 Working days",
          },
        },
      },
      {
        currency: "AUD",
        currency_name: "Australian Dollar",
        currency_symbol: "$",
        transfer_types: {
          wire: {
            description: "SWIFT Wire transfer",
            arrival: "Arrives within 1-2 Working days",
            arrival_time: "1-2 Working days",
          },
        },
      },
    ],
  };
});

import { defineEventHandler } from "../../../../util";

export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        type: "WIRE",
        bank_id: "3b25e6c2-4043-4b06-b33e-cc07da95a7b8",
        bank_name: "Wells Fargo",
        account_number: "123454321",
        account_name: "Zhang Junxian",
        asset_fiat: "USD",
        fee: 30,
        arrival: "Arrives within 1-2 Working days",
        arrival_time: "1-2 Working days",
        note: null,
        updated_at: "2024-06-19T03:44:23.000000Z",
      },
      {
        type: "WIRE",
        bank_id: "abf58fe6-670d-4779-8a76-859fbd32f34e",
        bank_name: "tset1",
        account_number: "test1",
        account_name: "Lily",
        asset_fiat: "USD",
        fee: 30,
        arrival: "Arrives within 1-2 Working days",
        arrival_time: "1-2 Working days",
        note: null,
        updated_at: "2024-03-28T19:05:40.000000Z",
      },
      {
        type: "WIRE",
        bank_id: "a35c46a7-d4ef-4e4d-913d-bc361cc65631",
        bank_name: "2312",
        account_number: "1231",
        account_name: "123",
        asset_fiat: "USD",
        fee: 30,
        arrival: "Arrives within 1-2 Working days",
        arrival_time: "1-2 Working days",
        note: null,
        updated_at: "2023-10-31T11:03:40.000000Z",
      },
    ],
  };
  //   return {
  //     status: "success",
  //     code: "100000",
  //     message: "success",
  //     data: [
  //       {
  //         type: "wire",
  //         bank_id: "7c91daa7-4c83-4340-9a95-9b8152986f08",
  //         bank_name: "fdasfd",
  //         account_number: "fdadfasfdsaf",
  //         asset_fiat: "USD",
  //         fee: 30,
  //         arrival: "Arrives within 1-2 days",
  //         arrival_time: "1-2 days",
  //         note: null,
  //         updated_at: "2023-03-09T11:40:35.000000Z",
  //       },
  //     ],
  //   };
});

import { defineEventHandler } from "../../../util";



function generateRandomNumber(min: number, max: number, decimalPlaces: number) {
  const factor = Math.pow(10, decimalPlaces);
  return (Math.random() * (max - min) + min).toFixed(decimalPlaces);
}

export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        created: "2024-06-24T02:09:39.445939Z",
        pair: "USDTUSD",
        price: 64584.55,
        quantity: generateRandomNumber(100, 200, 4),
        processing_fee: "2.50",
        network_fee: 0.92,
        side: "buy",
        size: 100,
      },
    ],
  };
});

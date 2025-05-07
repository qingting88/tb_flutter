import { defineEventHandler } from "../../../util";

const timeout=(time:number)=>{
  return new Promise((resolve)=>{
    setTimeout(()=>{
      resolve(0)
    },time)
  })
}
export default defineEventHandler(async () => {
  await timeout(5000)
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        USDTUSD: {
          minimum_size: 50,
          minimum_quantity: 10,
          maximum_quantity: 600,
        },
        BTCUSD: {
          minimum_size: 50,
          minimum_quantity: 0.0001,
          maximum_quantity: 50,
        },
        ETHUSD: {
          minimum_size: 50,
          minimum_quantity: 0.005,
          maximum_quantity: 200,
        },
        LTCUSD: {
          minimum_size: 50,
          minimum_quantity: 0.1,
          maximum_quantity: 2000,
        },
        BCHUSD: {
          minimum_size: 50,
          minimum_quantity: 0.01,
          maximum_quantity: 500,
        },
        BTCUSDT: {
          minimum_size: 0,
          minimum_quantity: 0.0003,
          maximum_quantity: 50,
        },
        ETHUSDT: {
          minimum_size: 0,
          minimum_quantity: 0.005,
          maximum_quantity: 200,
        },
        LTCUSDT: {
          minimum_size: 0,
          minimum_quantity: 0.1,
          maximum_quantity: 2000,
        },
        USDTGBP: {
          minimum_size: 40,
          minimum_quantity: 10,
          maximum_quantity: 500000,
        },
        BTCGBP: {
          minimum_size: 40,
          minimum_quantity: 0.0003,
          maximum_quantity: 50,
        },
        ETHGBP: {
          minimum_size: 40,
          minimum_quantity: 0.005,
          maximum_quantity: 200,
        },
        USDTEUR: {
          minimum_size: 50,
          minimum_quantity: 10,
          maximum_quantity: 500000,
        },
        BTCEUR: {
          minimum_size: 50,
          minimum_quantity: 0.0003,
          maximum_quantity: 50,
        },
        ETHEUR: {
          minimum_size: 50,
          minimum_quantity: 0.005,
          maximum_quantity: 200,
        },
        USDTCHF: {
          minimum_size: 50,
          minimum_quantity: 10,
          maximum_quantity: 500000,
        },
        BTCCHF: {
          minimum_size: 50,
          minimum_quantity: 0.0003,
          maximum_quantity: 50,
        },
        ETHCHF: {
          minimum_size: 50,
          minimum_quantity: 0.005,
          maximum_quantity: 200,
        },
        USDTJPY: {
          minimum_size: 7845,
          minimum_quantity: 10,
          maximum_quantity: 500000,
        },
        BTCJPY: {
          minimum_size: 7845,
          minimum_quantity: 0.0003,
          maximum_quantity: 50,
        },
        ETHJPY: {
          minimum_size: 7845,
          minimum_quantity: 0.005,
          maximum_quantity: 200,
        },
        USDTCAD: {
          minimum_size: 70,
          minimum_quantity: 10,
          maximum_quantity: 500000,
        },
        BTCCAD: {
          minimum_size: 70,
          minimum_quantity: 0.0003,
          maximum_quantity: 50,
        },
        ETHCAD: {
          minimum_size: 70,
          minimum_quantity: 0.005,
          maximum_quantity: 200,
        },
        USDTAUD: {
          minimum_size: 80,
          minimum_quantity: 10,
          maximum_quantity: 500000,
        },
        BTCAUD: {
          minimum_size: 80,
          minimum_quantity: 0.0003,
          maximum_quantity: 50,
        },
        ETHAUD: {
          minimum_size: 80,
          minimum_quantity: 0.005,
          maximum_quantity: 200,
        },
      },
    ],
  };
});

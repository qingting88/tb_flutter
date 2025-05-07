import { defineEventHandler } from "../../../util";

export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        url: "https://alchemy.veriff.com/v/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTc3Mjk4NDEsInNlc3Npb25faWQiOiIzOTM4MDBmZi03ZDAxLTQ5YTItODc4Yy0xNmQ2NjdmZDc3ZTAiLCJpaWQiOiJhZTczNzY2Yi1lNGI0LTQ5M2MtODFjNy0zYWIwZGUwOTllMTAifQ.8TrBfly17BpTxBdOUBvIf4Z9b1IlRl5oMhqnHc3Tg4w",
      },
    ],
  };
});

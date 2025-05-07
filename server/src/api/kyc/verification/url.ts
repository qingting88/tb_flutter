import { defineEventHandler } from "../../../util";

export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      {
        verification_url:
          "https://alchemy.veriff.com/v/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTcyOTIwNDIsInNlc3Npb25faWQiOiI5ZTM0NzMyZi00YjZiLTQzOWUtYjIxMS01OWU3YzAyMmY2NjgiLCJpaWQiOiI2YzU2YjQ4Ni0yMDQxLTRmZjgtOTQ5My01MmRiNzZiZmVlZDkifQ.hleDk1VA5Gv0OsiQXczsD4HkcQG63aNqm3cjQY1h3hU",
      },
    ],
  };
});

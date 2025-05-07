import { defineEventHandler } from "../../../util";

export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "Data fetched",
    data: [
      {
        status: "Requested",
        requests: [
          // {
          //   response_id: 363,
          //   request: "Redo the ID verification",
          //   description:
          //     '{"texts":[{"text":"Use your phone to complete this verification."},{"text":"Do NOT take photos of your ID document from a computer screen, the document has to be with you physically."}],"files":[]}',
          //   response:
          //     '{"text":"In Progress","link":"https:\\/\\/station.veriff.com\\/verifications\\/b2cab078-dcaf-4b97-a6c8-ff198de4bcb5","files":[]}',
          //   response_type: "veriff",
          //   status: "Requested",
          //   reviewed_by: null,
          //   file_type: "",
          //   file_required: false,
          // },
          {
            response_id: 102,
            request: "Upload the proof of address",
            description:
              '{"texts":[{"text":"Upload a recent (last 3 months) proof of address in PDF format. Accepted documents include utility bills, bank statements and rental agreements."},{"title":"Requirements:","list":[{"title":"Complete:","content":"Include your name, address, date, and all pages."},{"title":"Original:","content":"No markings or alterations."},{"title":"Physial Address:","content":"No PO Box."}]},{"title":"","list":[{"title":"Note:","content":"Photos of envelopes or incomplete documents will not be accepted"}]}]}',
            response: null,
            response_type: "text_files_no_placeholder",
            status: "Requested",
            reviewed_by: null,
            file_type: "institution_doc_additional",
            file_required: true,
          },
          // {
          //   rfi_id: 82,
          //   type: "Mixed",
          //   status: "Requested",
          //   requests: [
          //     {
          //       response_id: 102,
          //       request: "Upload the proof of address",
          //       description:
          //         '{"texts":[{"text":"Upload a recent (last 3 months) proof of address in PDF format. Accepted documents include utility bills, bank statements and rental agreements."},{"title":"Requirements:","list":[{"title":"Complete:","content":"Include your name, address, date, and all pages."},{"title":"Original:","content":"No markings or alterations."},{"title":"Physial Address:","content":"No PO Box."}]},{"title":"","list":[{"title":"Note:","content":"Photos of envelopes or incomplete documents will not be accepted"}]}]}',
          //       response: null,
          //       response_type: "text_files_no_placeholder",
          //       status: "Requested",
          //       reviewed_by: null,
          //       file_type: "institution_doc_additional",
          //       file_required: true,
          //     },
          //   ],
          //   example_file_dir: "https://qaapi.legendtrading.com/pdf/rfi/",
          // },
          // {
          //   response_id: 364,
          //   request: "Upload the proof of address",
          //   description:
          //     '{"texts":[{"text":"Official documents that show your address, such as utility bills, bank statements, apartment rental agreement, etc."}],"files":[{"file_name":"Utility_bill.pdf"},{"file_name":"Bank_statement.pdf"}]}',
          //   response: null,
          //   response_type: "files",
          //   status: "Requested",
          //   reviewed_by: null,
          //   file_type: "institution_doc_additional",
          //   file_required: true,
          // },
          // {
          //   response_id: 365,
          //   request: "Upload the recent bank statement",
          //   description:
          //     '{"texts":[{"text":"The latest month’s bank statement. You may login into your online banking website and download them from the “Account Statements” page."}],"files":[{"file_name":"Bank_statement_1.pdf"},{"file_name":"Bank_statement_2.pdf"}]}',
          //   response: null,
          //   response_type: "files",
          //   status: "Requested",
          //   reviewed_by: null,
          //   file_type: "institution_doc_additional",
          //   file_required: true,
          // },
          // {
          //   response_id: 366,
          //   request: "Explain the source of income with supporting documents",
          //   description:
          //     '{"texts":[{"text":"The income proof can be your paystubs, property sale agreement, stock sale confirmations, etc."}],"files":[{"file_name":"Paystubs.pdf"}]}',
          //   response: null,
          //   response_type: "text_files",
          //   status: "Requested",
          //   reviewed_by: null,
          //   file_type: "institution_doc_additional",
          //   file_required: true,
          // },
          // {
          //   response_id: 367,
          //   request: "Work experience in the past 3 years",
          //   description:
          //     '{"texts":[{"text":"List one job in one line with the job title, company and year month. For example: Software Developer, ABC Inc, 2019 April - 2021 August.<br/>Leave it empty if you didn’t have any job in the past 3 year."}],"files":[]}',
          //   response: null,
          //   response_type: "text",
          //   status: "Requested",
          //   reviewed_by: null,
          //   file_type: "",
          //   file_required: false,
          // },
          // {
          //   response_id: 368,
          //   request:
          //     "Please provide other support documents or explanation to help us approve your account.21212",
          //   description: null,
          //   response: null,
          //   response_type: "text_files",
          //   status: "Requested",
          //   reviewed_by: null,
          //   file_type: "institution_doc_additional",
          //   file_required: false,
          // },
        ],
      },
    ],
  };
});

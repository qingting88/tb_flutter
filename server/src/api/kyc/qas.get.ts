import { defineEventHandler } from "../../util";


export default defineEventHandler(() => {
  return {
    status: "success",
    code: "100000",
    message: "success",
    data: [
      [
        {
          title: "How will you use this trading account?",
          type: "checkbox",
          options: [
            {
              name: "short_term",
              text: "Short term savings/investing",
              value: false,
            },
            {
              name: "long_term",
              text: "Long term savings/investing",
              value: false,
            },
            {
              name: "active_trade",
              text: "Actively trade",
              value: false,
            },
            {
              name: "remittance",
              text: "Remittance payments",
              value: false,
            },
          ],
        },
        {
          title: null,
          type: "textarea",
          name: "other",
          value: "",
          text: "Other:",
        },
      ],
      [
        {
          title: "What is the source of income?",
          type: "checkbox",
          options: [
            {
              name: "employment",
              text: "Employment Income",
              value: false,
            },
            {
              name: "investment",
              text: "Investment Income",
              value: false,
            },
            {
              name: "retirement",
              text: "Retirement Income",
              value: false,
            },
            {
              name: "social_secutiry",
              text: "Social Security",
              value: false,
            },
            {
              name: "unemployment",
              text: "Unemployed",
              value: false,
            },
          ],
        },
        {
          title: null,
          type: "textarea",
          name: "other",
          value: "",
          text: "Other:",
        },
      ],
      [
        {
          title: "What is the source of wealth?",
          type: "checkbox",
          options: [
            {
              name: "business",
              text: "Income from Own Business or Sale of Business",
              value: false,
            },
            {
              name: "employment",
              text: "Income from Employment and/or Bonuses",
              value: false,
            },
            {
              name: "inheritance",
              text: "Inheritance or Family, Gift, Trust Proceeds",
              value: false,
            },
            {
              name: "securities",
              text: "Securities Investing",
              value: false,
            },
            {
              name: "compensation",
              text: "Compensation Payment/Legal Settlement",
              value: false,
            },
            {
              name: "sale_property",
              text: "Sale of Real Property",
              value: false,
            },
            {
              name: "household_wealth",
              text: "Household Wealth (e.g., spouse, minors, financial dependents)",
              value: false,
            },
          ],
        },
        {
          title: null,
          type: "textarea",
          name: "other",
          value: "",
          text: "Other:",
        },
      ],
      [
        {
          title: "What is your employment status?",
          type: "radio",
          name: "employment",
          value: "",
          options: [
            {
              value: "employed",
              text: "Employed (Not Owner)",
            },
            {
              value: "business_owner",
              text: "Business Owner",
            },
            {
              value: "not_employed",
              text: "Not Employed",
            },
            {
              value: "student",
              text: "Student",
            },
            {
              value: "retired",
              text: "Retired",
            },
          ],
        },
      ],
    ],
  };
});

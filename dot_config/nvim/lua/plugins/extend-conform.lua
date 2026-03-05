return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      markdown = { "prettier" },
      python = { "black", "isort" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      vue = { "prettier" },
      json = { "prettier" },
    },
    {
      formatters = {
        black = { args = { "--line-length", "120", "-" } },
      },
    },
  },
}

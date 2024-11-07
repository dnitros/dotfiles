return {
  "stevearc/conform.nvim",
  event = {
    "BufWritePre",
  },
  keys = {
    {
      "<leader>mp",
      function()
        require("conform").format()
      end,
      desc = "Format file or range (in visual mode)",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = {
        "stylua",
      },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      lsp_fallback = true,
      async = true,
      timeout_ms = 1000,
    },
  },
}

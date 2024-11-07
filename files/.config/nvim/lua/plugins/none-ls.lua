return {
  "nvimtools/none-ls.nvim",
  enabled = true,
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
  keys = {
    {
      "<leader>gf",
      function()
        vim.lsp.buf.format()
      end,
      desc = "Format and lint file with LSP",
    },
  },
}

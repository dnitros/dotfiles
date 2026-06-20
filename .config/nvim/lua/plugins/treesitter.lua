return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function ()
    local ts = require("nvim-treesitter")

    ts.setup({
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })

    local ensure_installed = {
      "bash",
      "c",
      "lua",
      "vim",
      "vimdoc",
      "json",
      "yaml",
      "markdown",
      "query",
      "regex",
    }

    ts.install(ensure_installed, { summary = true })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
      end,
    })
  end,
}

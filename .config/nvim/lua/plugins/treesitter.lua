return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "lua",
      "query",
      "regex",
      "vim",
      "vimdoc",
    },
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  },
  config = function (_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}

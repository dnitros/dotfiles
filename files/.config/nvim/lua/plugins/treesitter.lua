return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = {
      "BufReadPre",
      "BufNewFile"
    },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "lua",
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
  },
}

return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
    transparent_background = true,
    dim_inactive = {
      enabled = true,
    },
    auto_integrations = true,
  },
  init = function()
    vim.cmd.colorscheme "catppuccin"
  end,
}

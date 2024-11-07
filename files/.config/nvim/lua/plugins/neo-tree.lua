return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      lazy = true,
    },
    {
      "nvim-tree/nvim-web-devicons",
      lazy = true,
    },
    {
      "MunifTanjim/nui.nvim",
      lazy = true,
    },
  },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  keys = {
    {
      "<C-n>",
      "<Cmd>Neotree toggle<CR>",
      desc = "Toggle Neotree",
      mode = "n",
    },
  },
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = true,
        hide_gitignored = false,
      },
      hijack_netrw_behavior = "open_default",
    },
  },
}

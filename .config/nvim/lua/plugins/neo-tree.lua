return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      version = false,
    },
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
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
    log_level = "info",
    close_if_last_window = true,
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        never_show = {
          ".DS_Store",
          "thumbs.db",
          ".git",
        },
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
      hijack_netrw_behavior = "disabled",
    },
  },
}

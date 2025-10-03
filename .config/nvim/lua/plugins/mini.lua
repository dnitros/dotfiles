return {
  {
    "nvim-mini/mini.files",
    keys = {
      {
        "<leader>e",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "<leader>E",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
  },
  {
    "nvim-mini/mini.statusline",
    event = "VeryLazy",
    opts = {
      use_icons = true,
    },
  },
  {
    "nvim-mini/mini.tabline",
    event = "BufReadPre",
    opts = {
      show_icons = true,
    },
  },
  {
    "nvim-mini/mini.surround",
    event = "InsertEnter",
    opts = {
      mappings = {
        add = "sa",
        delete = "sd",
        find = "",
        find_left = "",
        highlight = "",
        replace = "",
        suffix_last = "",
        suffix_next = "",
      },
    },
  },
  {
    "nvim-mini/mini.pairs",
    event = "InsertEnter",
    opts = {
      modes = { insert = true, command = false, terminal = false },
      mappings = {
        [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
        ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
        ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
        ["["] = {
          action = "open",
          pair = "[]",
          neigh_pattern = ".[%s%z%)}%]]",
          register = { cr = false },
        },
        ["{"] = {
          action = "open",
          pair = "{}",
          neigh_pattern = ".[%s%z%)}%]]",
          register = { cr = false },
        },
        ["("] = {
          action = "open",
          pair = "()",
          neigh_pattern = ".[%s%z%)]",
          register = { cr = false },
        },
        ['"'] = {
          action = "closeopen",
          pair = '""',
          neigh_pattern = "[^%w\\][^%w]",
          register = { cr = false },
        },
        ["'"] = {
          action = "closeopen",
          pair = "''",
          neigh_pattern = "[^%w\\][^%w]",
          register = { cr = false },
        },
        ["`"] = {
          action = "closeopen",
          pair = "``",
          neigh_pattern = "[^%w\\][^%w]",
          register = { cr = false },
        },
      },
    },
  },
}

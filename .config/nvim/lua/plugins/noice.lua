return {
  "folke/noice.nvim",
  event = "CmdlineEnter",
  opts = {
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            {
              find = "%d+L, %d+B",
            },
            {
              find = "; after #%d+",
            },
            {
              find = "; before #%d+",
            },
          },
        },
        view = "mini",
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
    },
  },
  dependencies = {
    {
      "MunifTanjim/nui.nvim",
      lazy = true,
    },
    {
      "rcarriga/nvim-notify",
      lazy = true,
    },
  },
}

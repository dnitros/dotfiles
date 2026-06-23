-- Vertical cursor everywhere
vim.opt.guicursor = "a:ver25-blinkon0"

vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
  pattern = "*",
  command = "set guicursor=a:ver25-blinkon0",
})

-- Vertical cursor everywhere, but blinking only in insert mode
vim.opt.guicursor = "n-v-c-sm:ver25-blinkon0,i-ci-ve:ver25-blinkon0,r-cr-o:ver25-blinkon0,a:ver25-blinkon0"

vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend", "VimResume" }, {
  pattern = "*",
  command = "set guicursor=a:ver25-blinkon0",
})

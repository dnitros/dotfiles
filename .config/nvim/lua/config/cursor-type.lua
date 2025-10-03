-- Vertical cursor everywhere, but blinking only in insert mode
vim.opt.guicursor = "n-v-c-sm:ver25-blinkon0,i-ci-ve:ver25-blinkwait700-blinkoff400-blinkon250,r-cr-o:ver25-blinkon0"

vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  command = "set guicursor=a:ver25",
})

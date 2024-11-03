local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

return function(opts)
  opts = vim.tbl_deep_extend("force", {
    spec = {
      { import = "plugins" },
    },
    defaults = { lazy = true },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = true },
    performance = {
      cache = {
        enabled = true,
      },
    },
    debug = false,
  }, opts or {})
  require("lazy").setup(opts)
end
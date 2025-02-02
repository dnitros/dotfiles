local function map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- New Windows
map("n", "<leader>o", "<CMD>vsplit<CR>")
map("n", "<leader>p", "<CMD>split<CR>")

-- Resize Windows
map("n", "<M-Left>", "<C-w><")
map("n", "<M-Right>", "<C-w>>")
map("n", "<M-Up>", "<C-w>+")
map("n", "<M-Down>", "<C-w>-")

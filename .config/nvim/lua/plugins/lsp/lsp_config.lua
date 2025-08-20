return {
  "neovim/nvim-lspconfig",
  cmd = {
    "LspInfo",
    "LspInstall",
    "LspStart",
  },
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason-lspconfig.nvim",
  },
  init = function()
    vim.opt.signcolumn = "yes"
  end,
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP actions",
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(event)
        local opts = { buffer = event.buf }

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)

        opts.desc = "Show LSP references"
        keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)

        opts.desc = "See available code actions"
        keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
      end,
    })
    local capabilities = cmp_nvim_lsp.default_capabilities()
    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
    })
  end,
}

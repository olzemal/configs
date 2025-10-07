require "lib"

-- LSP
local lspconfig = require('lspconfig')
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.ast_grep.setup({ capabilities = lsp_capabilities })
lspconfig.bashls.setup({ capabilities = lsp_capabilities })
lspconfig.gopls.setup({ capabilities = lsp_capabilities })
lspconfig.helm_ls.setup({
  capabilities = lsp_capabilities,
  filetypes = { "helm", "yaml", "gotmpl", "tpl" }
})
lspconfig.jsonls.setup({ capabilities = lsp_capabilities })
lspconfig.lua_ls.setup({ capabilities = lsp_capabilities })
lspconfig.marksman.setup({ capabilities = lsp_capabilities })
lspconfig.nixd.setup({ capabilities = lsp_capabilities })
lspconfig.pyright.setup({ capabilities = lsp_capabilities })

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  float = { border = "rounded" },
})

keymap('n', '<leader>r', vim.lsp.buf.rename)

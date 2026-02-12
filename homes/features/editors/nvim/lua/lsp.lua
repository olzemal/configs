require "lib"

-- LSP
local lspconfig = require('lspconfig')
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.ast_grep.setup{ capabilities = lsp_capabilities }
lspconfig.bashls.setup{ capabilities = lsp_capabilities }
lspconfig.gopls.setup{ capabilities = lsp_capabilities }
lspconfig.jsonls.setup{
  capabilities = lsp_capabilities,
  cmd = {"vscode-json-languageserver", "--stdio"}
}
lspconfig.lua_ls.setup{ capabilities = lsp_capabilities }
lspconfig.marksman.setup{ capabilities = lsp_capabilities }
lspconfig.nixd.setup{ capabilities = lsp_capabilities }
lspconfig.pyright.setup{ capabilities = lsp_capabilities }

local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = normal.fg, bg = "none" })

require("lsp_signature").setup {
  hint_enable = false,
  floating_window_above_cur_line = false,
  floating_window_off_x = 0,
  floating_window_off_y = -2
}

vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  float = { border = "rounded" },
}

keymap('n', 'leaderr', vim.lsp.buf.rename)

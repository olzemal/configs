require "lib"

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- ast
vim.lsp.config.ast_grep = {
  capabilities = lsp_capabilities,
}
vim.lsp.enable('ast_grep')

-- bash
vim.lsp.config.bashls = {
  capabilities = lsp_capabilities,
}
vim.lsp.enable('bashls')

-- golang
vim.lsp.config.gopls = {
  capabilities = lsp_capabilities,
}
vim.lsp.enable('gopls')

-- json
vim.lsp.config.jsonls = {
  capabilities = lsp_capabilities,
  cmd = {"vscode-json-languageserver", "--stdio"}
}
vim.lsp.enable('jsonls')

-- lua
vim.lsp.config.lua_ls = {
  capabilities = lsp_capabilities,
}
vim.lsp.enable('lua_ls')

-- markdown
vim.lsp.config.marksman = {
  capabilities = lsp_capabilities,
}
vim.lsp.enable('marksman')

-- nix
vim.lsp.config.nixd = {
  capabilities = lsp_capabilities,
}
vim.lsp.enable('nixd')

-- python
vim.lsp.config.pyright = {
  capabilities = lsp_capabilities,
}
vim.lsp.enable('pyright')

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

keymap('n', '<leader>r', vim.lsp.buf.rename)

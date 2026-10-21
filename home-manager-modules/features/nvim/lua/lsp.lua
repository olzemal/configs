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
  settings = {
    gopls = {
      buildFlags = { "-tags=e2e" },
      analyses = {
        unusedparams = true,

        SA6001 = false, -- missing optimization when indexing maps by byte slices
        SA6002 = false, -- storing non-pointer values in sync.Pool allocates
        SA6003 = false, -- converting a string to []rune before ranging over it
      },
      staticcheck = true,
      gofumpt = true,
      usePlaceholders = true,
      codelenses = { test = true },
      hints = {
        parameterNames = true,
        ignoredError = true,
        constantValues = true,
      },
    },
  },
}
vim.lsp.enable('gopls')

autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})

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

vim.lsp.inlay_hint.enable(true)

local treesitter = require('nvim-treesitter.configs')
local parsers_path = vim.fn.stdpath("data") .. "/parsers"

vim.opt.runtimepath:append(parsers_path)

treesitter.setup {
  ensure_installed = { "yaml", "gotmpl", "go", "gomod", "lua", "bash", "json" },
  parser_install_dir = parsers_path,
  highlight = { enable = true },
  indent = { enable = true }
}

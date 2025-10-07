local treesitter = require('nvim-treesitter.configs')
local parsers_path = vim.fn.stdpath("data") .. "/parsers"

vim.opt.runtimepath:append(parsers_path)

treesitter.setup {
  ensure_installed = { "yaml", "gotmpl", "go", "gomod", "lua", "bash", "json" },
  parser_install_dir = parsers_path,
  highlight = { enable = true },
  playground = { enable = true }
}

-- treat yaml as gotmpl but parse text as yaml
vim.treesitter.language.register('gotmpl', 'yaml')
vim.treesitter.query.set("gotmpl", "injections", [[
  ((text) @injection.content
    (#set! injection.combined)
    (#set! injection.include-children)
    (#set! injection.language "yaml"))
  ]])

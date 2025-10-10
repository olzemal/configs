local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
  auto_install = false,
  highlight = { enable = true },
  playground = { enable = true }
}

-- treat yaml as gotmpl but parse text as yaml
vim.treesitter.language.register('gotmpl', 'yaml')
vim.treesitter.query.set("gotmpl", "injections", [[
  ((text) @injection.content
    (#set! injection.include-children)
    (#set! injection.combined)
    (#set! injection.language "yaml"))
  ]])

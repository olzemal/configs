require "lib"

local treesitter = require('nvim-treesitter.configs')

keymap({'n', 'v'}, 's', '<Nop>')

treesitter.setup {
  auto_install = false,
  highlight = { enable = true },
  playground = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "ss",
      node_incremental = "se",
      node_decremental = "sd",
    }
  }
}

-- treat yaml as gotmpl but parse text as yaml
vim.treesitter.language.register('gotmpl', 'yaml')
vim.treesitter.query.set("gotmpl", "injections", [[
  ((text) @injection.content
    (#set! injection.include-children)
    (#set! injection.combined)
    (#set! injection.language "yaml"))
  ]])

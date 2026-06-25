require "lib"

local treesitter = require('nvim-treesitter')

keymap({'n', 'v'}, 's', '<Nop>')

treesitter.setup {
  auto_install = false,
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "ss",
      node_incremental = "se",
      node_decremental = "sd",
    }
  }
}

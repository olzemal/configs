require "lib"

local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup{
  defaults = {
    scroll_strategy = "limit"
  }
}

local opts = { noremap = true, silent = true }

keymap('n', 'gd', builtin.lsp_definitions, opts)
keymap('n', 'gr', builtin.lsp_references, opts)
keymap('n', 'gi', builtin.lsp_implementations, opts)

keymap('n', '<C-P>', builtin.live_grep, opts)
keymap('n', '<C-F>', builtin.find_files, opts)

keymap('n', '<Leader>t', builtin.treesitter, opts)
keymap('n', '<Leader>s', builtin.spell_suggest, opts)

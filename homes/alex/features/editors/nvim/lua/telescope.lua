require("lib")

local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup{
  defaults = {
    scroll_strategy = "limit"
  }
}

keymap('n', '<C-P>', builtin.live_grep)
keymap('n', '<C-F>', builtin.find_files)

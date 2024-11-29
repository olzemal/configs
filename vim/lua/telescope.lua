require "lib"

-- ctrl-p
keymap('n', '<c-p>', function() require('telescope.builtin').live_grep() end)
keymap('n', '<c-f>', function() require('telescope.builtin').find_files() end)

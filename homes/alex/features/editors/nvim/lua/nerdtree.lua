require "lib"

-- NerdTree
NERDTreeMinimalUI      = 1
NERDTreeQuitOnOpen     = 1
NERDTreeCustomOpenArgs = {['file'] = {['where'] = 't'}}

keymap('n', '<Leader>e', '<cmd>NERDTreeToggle<CR>')

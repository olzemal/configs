--------------------------------
-- [[ Setup ]]
--------------------------------
require "lib"

local autoload_dir = vim.fn.stdpath('data') .. '/site/autoload'
if not vim.fn.isdirectory(autoload_dir) then
  vim.fn.mkdir(autoload_dir, 'p')
end

--------------------------------
-- [[ General Options ]]
--------------------------------

-- Colors
autocmd('VimEnter', {
  command = 'hi Normal ctermbg=none'
})
autocmd('colorscheme', {
  command = 'hi SpellBad cterm=underline ctermfg=none ctermbg=none'
})
vim.cmd.highlight({'Pmenu', 'ctermbg=darkgrey', 'ctermfg=white'})
vim.cmd.highlight({'PmenuSel', 'ctermbg=blue', 'ctermfg=black'})

-- markdown
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_math        = 1

-- Enable spell checking for markdown and commit messages
autocmd('FileType', {
  pattern = 'markdown',
  command = 'setlocal spell'
})
autocmd({'BufRead', 'BufNewFile'}, {
  pattern = '*.md',
  command = 'setlocal spell'
})
autocmd({'BufRead', 'BufNewFile'}, {
  pattern = '*.MD',
  command = 'setlocal spell'
})
autocmd('FileType', {
  pattern = 'gitcommit',
  command = 'setlocal spell'
})

-- Trailing whitespace
vim.opt.listchars = {
  ['tab']   = '>>',
  ['trail'] = '·'
}
vim.opt.list = true
vim.fn.matchadd("TrailingWhiteSpace", [[\v\s+$]])
vim.cmd.highlight({'TrailingWhiteSpace', 'ctermbg=darkgrey', 'guibg=darkgrey'})

-- Undo
vim.opt.undofile   = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

-- Buffers
vim.opt.hidden     = true
vim.opt.tabline    = '2'
vim.opt.laststatus = 2

-- Command line
vim.opt.wildmenu  = true
vim.opt.cmdheight = 2

-- Indicators
vim.opt.ruler       = true
vim.opt.number      = true
vim.opt.colorcolumn = {120}

-- Indentation
vim.opt.expandtab   = true
vim.opt.tabstop     = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth  = 2
autocmd('FileType', {
  pattern = 'Makefile',
  callback = function() vim.opt.expandtab = false end
})

-- Remember last cursor position
autocmd('BufReadPost', {
  pattern = {'*'},
  command = [[if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif]]
})

-- Automatically create undo break points
for _, symbol in ipairs({',', '.', ':', ';', '-', '!', '?'}) do
  keymap('i', symbol, symbol .. '<c-g>u')
end

-- Searching
vim.opt.hlsearch   = false
vim.opt.incsearch  = true
vim.opt.ignorecase = true
vim.opt.smartcase  = true
vim.opt.scrolloff  = 4
vim.opt.path:append('**')

-- Annoying things
vim.opt.visualbell = false
vim.opt.mouse = ''

--------------------------------
-- [[ Bindings ]]
--------------------------------

vim.g.mapleader = ' '

keymap('n', 'Y', 'y$')

-- Prevent cursor from jumping around too much
keymap('n', 'n', 'nzzzv')
keymap('n', 'N', 'Nzzzv')
keymap('n', 'J', 'mzJ`z')

-- Moving text
keymap('v', 'J',         '<cmd>m >+1<CR>gv=gv')
keymap('v', 'K',         '<cmd>m <-2<CR>gv=gv')
keymap('n', '<Leader>j', '<cmd>m .+1<CR>==')
keymap('n', '<Leader>k', '<cmd>m .-2<CR>==')

-- Toggle Numbers
keymap('n', '<Leader>n', '<cmd>set number!<CR>')

-- Formatting
keymap('n', '<Leader>f', 'gqip')

-- Bash / sh
autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    keymap('n', '<Leader>r', '<cmd>!./%<CR>')
    keymap('n', '<Leader>t', '<cmd>!shellcheck ./%<CR>')
  end
})

-- Terraform
autocmd('FileType', {
  pattern = 'terraform',
  callback = function()
    keymap('n', '<Leader>r', '<cmd>!terraform apply<CR>')
    keymap('n', '<Leader>t', '<cmd>!terraform validate<CR>')
  end
})

-- C
autocmd('FileType', {
  pattern = 'c',
  callback = function()
    keymap('n', '<Leader>r', '<cmd>!gcc -o /tmp/%.o % && /tmp/%.o<CR>')
  end
})

-- Python
autocmd('FileType', {
  pattern = 'python',
  callback = function()
    keymap('n', '<Leader>r', '<cmd>!python3 ./%<CR>')
  end
})

-- git
keymap('n', 'gb', '<cmd>Git blame<CR>')

-- init.lua by Alexander Olzem

--------------------------------
-- [[ Setup ]]
--------------------------------
local autoload_dir = vim.fn.stdpath('data') .. '/site/autoload'
if not vim.fn.isdirectory(autoload_dir) then
  vim.fn.mkdir(autoload_dir, 'p')
end

-- Short versions of functions
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local keymap  = vim.keymap.set

--------------------------------
-- [[ Plugins ]]
--------------------------------
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('morhetz/gruvbox')                                            -- Gruvbox
Plug('junegunn/vim-easy-align')                                    -- Alignment
Plug('fatih/vim-go', {['do'] = ':GoInstallBinaries'})              -- Vim-go
Plug('imsnif/kdl.vim')                                             -- KDL Support
Plug('scrooloose/nerdtree')                                        -- Nerd Tree
Plug('ixru/nvim-markdown')                                         -- Markdown
Plug('airblade/vim-gitgutter')                                     -- Git Diff
Plug('tpope/vim-fugitive')                                         -- Git Blame
Plug('mg979/vim-visual-multi', {['branch'] = 'master'})            -- Multi cursor
Plug('dense-analysis/ale')                                         -- Linter
Plug('Konfekt/vim-DetectSpellLang')                                -- Detect language
Plug('nvim-telescope/telescope.nvim', {['tag'] = '0.1.3'})         -- Fuzzyfinder
Plug('nvim-lua/plenary.nvim')
Plug('nvim-tree/nvim-web-devicons')                                -- Icons
Plug('williamboman/mason.nvim')                                    -- LSP
Plug('williamboman/mason-lspconfig.nvim')
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')                                       -- Completion
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/cmp-emoji')
Plug('hrsh7th/nvim-cmp')
Plug('uga-rosa/cmp-dictionary')
Plug('SirVer/ultisnips')                                           -- Snippets
Plug('quangnguyen30192/cmp-nvim-ultisnips')
vim.call('plug#end')

--------------------------------
-- [[ Plugin Options ]]
--------------------------------

-- Color scheme
vim.cmd.colorscheme('gruvbox')
autocmd('VimEnter', {
  command = 'hi Normal ctermbg=none'
})
autocmd('colorscheme', {
  command = 'hi SpellBad cterm=underline ctermfg=none ctermbg=none'
})
vim.cmd.highlight({'Pmenu', 'ctermbg=darkgrey', 'ctermfg=white'})
vim.cmd.highlight({'PmenuSel', 'ctermbg=blue', 'ctermfg=black'})

-- vim-go
vim.g.go_fmt_fail_silently               = 1
vim.g.go_fmt_command                     = 'goimports'
vim.g.go_fmt_autosave                    = 1
vim.g.go_gopls_enabled                   = 1
vim.g.go_highlight_types                 = 1
vim.g.go_highlight_fields                = 1
vim.g.go_highlight_functions             = 1
vim.g.go_highlight_function_calls        = 1
vim.g.go_highlight_operators             = 1
vim.g.go_highlight_extra_types           = 1
vim.g.go_highlight_variable_declarations = 1
vim.g.go_highlight_variable_assignments  = 1
vim.g.go_highlight_build_constraints     = 1
vim.g.go_highlight_diagnostic_errors     = 1
vim.g.go_highlight_diagnostic_warnings   = 1
vim.g.go_auto_type_info                  = 1

-- markdown
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_math        = 1

-- NerdTree
NERDTreeMinimalUI      = 1
NERDTreeQuitOnOpen     = 1
NERDTreeCustomOpenArgs = {['file'] = {['where'] = 't'}}

-- Languages
vim.g.detectspelllang_langs = {
  ['aspell']   = {'en', 'de'},
  ['hunspell'] = {'en', 'de'},
}
vim.gdetectspelllang_lines     = 20 -- Evaluate the first 20 lines of a file
vim.gdetectspelllang_threshold = 20 -- Allow a maximum of 20% misspelled words

-- LSP
local lspconfig = require('lspconfig')
require('mason').setup()
require('mason-lspconfig').setup({ automatic_installation = true })
require('mason-lspconfig').setup_handlers({
  function(server)
    lspconfig[server].setup({})
  end,
})

-- Buffer Completion
local cmp = require'cmp'
cmp.register_source('emoji', require'cmp_emoji'.new())

cmp.setup({
  enabled = true,
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'path' },
    { name = 'emoji' },
    { name = 'dictionary', keyword_length = 4 }
  }, {
    { name = 'buffer' },
  })
})

-- Dictionary
local dicts = {
  ['*'] = {'/usr/share/dict/words'},
  ['de'] = {'/usr/share/dict/ngerman'}
}

require('cmp_dictionary').setup({
  paths = dicts['*'],
  exact_length = 2,
  first_case_insensitive = true,
  document = {
    enable = true,
    command = {'wn', '${label}', '-over'},
  },
})

autocmd('BufWrite', {
  pattern  = '*',
  callback = function()
    local d = dicts[vim.opt.spelllang._value] or {}
    vim.list_extend(d, dicts['*'])
    require('cmp_dictionary').setup({
      paths = d,
    })
  end
})

-- cmdline completion
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Default to static completion for SQL
vim.g.omni_sql_default_compl_type = 'syntax'

-- Linter settings
vim.g.ale_fixers = {
  ['*']  = {'remove_trailing_lines', 'trim_whitespace'},
  ['sh'] = {'shfmt'},
  ['go'] = {'gofmt'}
}
vim.g.ale_linters = {
  ['sh']   = {''},
  ['go']   = {'gofmt'},
  ['yaml'] = {'yamllint'}
}
vim.g.ale_fix_on_save = 1


--------------------------------
-- [[ General Options ]]
--------------------------------

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
autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.go',
  callback = function()
    vim.bo.expandtab  = false
    vim.bo.tabstop    = 4
    vim.bo.shiftwidth = 4
  end
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

-- Completion
vim.opt.completeopt:append('menuone')
vim.opt.completeopt:append('noselect')
vim.opt.shortmess:append('c')
vim.opt.previewheight = 5

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
vim.opt.pastetoggle = '<F11>'

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
keymap('v', 'ga',        '<Plug>(EasyAlign)')
keymap('n', 'ga',        '<Plug>(EasyAlign)')

-- ctrl-p
keymap('n', '<c-p>', function() require('telescope.builtin').live_grep() end)

-- NERDTree
keymap('n', '<Leader>e', '<cmd>NERDTreeToggle<CR>')

-- golang
autocmd('FileType', {
  pattern = 'go',
  callback = function()
    keymap('n', '<Leader>r', '<cmd>GoRun! %<CR>')
    keymap('n', '<Leader>t', '<cmd>!go test<CR>')
    keymap('n', '<Leader>v', '<cmd>GoVet!<CR>')
    keymap('n', '<Leader>b', '<cmd>GoBuild!<CR>')
    keymap('n', '<Leader>c', '<cmd>GoCoverageToggle<CR>')
    keymap('n', '<Leader>l', '<cmd>GoMetaLinter!<CR>')
  end
})

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


-- Markdown

local telescope_actions = require 'telescope.actions'

function generate_img_link()
  local opts = {
    attach_mappings = function(prompt_bufnr, map)
      telescope_actions.select_default:replace(function()
        telescope_actions.close(prompt_bufnr)
        local selection = require('telescope.actions.state').get_selected_entry()
        local path = selection[1]
        local start, _ = path:find('[%w%s!-={-|]+[_%.].+')
        local name = path:sub(start,#path)
        vim.cmd.normal('A\n'..'!['..name..'](./'..path..')')
      end)
      return true
    end
  }
  require('telescope.builtin').find_files(opts)
end

autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    keymap('n', '<Leader>i', ":lua generate_img_link()<CR>")
  end
})

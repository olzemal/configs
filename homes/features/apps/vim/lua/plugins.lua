-- plugins.lua

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
Plug('mfussenegger/nvim-dap')                                      -- Debugger
Plug('rcarriga/nvim-dap-ui')
Plug('nvim-neotest/nvim-nio')
Plug('leoluz/nvim-dap-go')
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

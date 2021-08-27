" .vimrc by Alexander Olzem

" The goal of this .vimrc file is to provide a portable configuration for the
" editor vim. 
" This configuration requires exactly 0 plugins and will run on most linux
" systems.

" Some nice things this config provides are:
" - spellchecking on markdown files
" - fuzzy finding
" - 2 space tabstops for yaml files
" - automatic undo breakpoints

"+---------------------------------------------------------------------------+
"| Settings                                                                  |
"+---------------------------------------------------------------------------+

" Enable auto indenting
if has('filetype')
    filetype indent plugin on
endif

" Enable syntax highliting
if has('syntax')
    syntax on
endif

" When editing a markdown file, enable spellcheck
augroup markdownSpell
    au!
    autocmd FileType markdown setlocal spell
    autocmd BufRead,BufNewFile *.md setlocal spell
    autocmd BufRead,BufNewFile *.MD setlocal spell
augroup END

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
augroup vimStartup
    au!
    autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ |   exe "normal! g`\""
        \ | endif
augroup END

" store backup, undo and swap files in temp directory
set undofile
set undolevels=1000
set undoreload=10000

set backup
set swapfile
set undodir=$HOME/.vim/tmp/undo
set backupdir=$HOME/.vim/tmp/backup
set directory=$HOME/.vim/tmp/swap

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" Keep buffers in background
set hidden

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Don't annoy me pls 
set visualbell t_vb=

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Set ruler at the right
set colorcolumn=80

" Indentation settings for using 4 spaces instead of tabs.
set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab
set smartindent

" Indentation settings for yaml (2 Spaces instead of tabs)
" also fold yaml files at indentations
augroup yaml
    au!
    autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType yaml set foldmethod=indent
    autocmd BufRead,BufNewFile *.yml setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

augroup Makefile
    au!
    autocmd FileType Makefile set noexpandtab
augroup END

" Search options
set nohlsearch
set incsearch
set ignorecase
set smartcase
set scrolloff=4

" Search down in subfolders
set path+=**

" Colors
colorscheme torte
highlight LineNr ctermfg=darkgrey
highlight ColorColumn ctermbg=darkgrey 
highlight Pmenu ctermbg=darkgrey ctermfg=white
highlight PmenuSel ctermbg=blue ctermfg=black

"+---------------------------------------------------------------------------+
"| Remaps                                                                    |
"+---------------------------------------------------------------------------+

let mapleader=" "

" Behave Y!
nnoremap Y y$

" Center next / previous
nnoremap n nzzzv
nnoremap N Nzzzv

" Keep the cursor where it was after line concatination
nnoremap J mzJ`z 

" Undo break points at end of sentences
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap : :<c-g>u
inoremap ; ;<c-g>u
inoremap - -<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Moving Text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==


" .vimrc by Alexander Olzem

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

source $VIMRUNTIME/vimrc_example.vim

" Enable auto indenting
if has('filetype')
    filetype indent plugin on
endif

" Enable syntax highliting
if has('syntax')
    syntax on
endif

" store backup, undo and swap files in temp directory
set undofile
set undolevels=1000
set undoreload=10000

set backup                        " enable backups
set swapfile                      " enable swaps
set undodir=$HOME/.vim/tmp/undo     " undo files
set backupdir=$HOME/.vim/tmp/backup " backups
set directory=$HOME/.vim/tmp/swap   " swap files

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

set hidden

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

"------------------------------------------------------------
" Usability options

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

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

" Use visual bell instead of beeping when doing something wrong
set visualbell

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display hybrid numbers on the left
set number relativenumber

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Set ruler
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

"------------------------------------------------------------
" Indentations

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab


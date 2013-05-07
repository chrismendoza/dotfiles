" not compatible with vi
set nocompatible

" Enable pathogen
execute pathogen#infect()

" Write the backup and swp files to a tmp dir instead (prevents lag)
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
set nowritebackup

" Turn on syntax highlighting
syntax on
" Turn on filetype recognition
filetype plugin on
" set colorscheme
set background=dark
colorscheme solarized
" Turn on mouse
set mouse=a

" Incremental search
set incsearch
" Ignore case
set ignorecase
" If uppercase letters are typed, case-sensitive
set smartcase
" Highlight the search matches in the file
set hlsearch

" Show line numbers
set number
" Show ruler
set ruler
" Don't wrap lines
set nowrap
" Highlight cursor line
set cursorline
" Show matching parenthesis
set showmatch

" insert tabs on the start of a line, not tabstop
set smarttab
" expand tabs to spaces
set expandtab
" set tab width
set softtabstop=4
set tabstop=4
set shiftwidth=4

" Speed up the terminal
set ttyfast
" only redraw when necessary
set lazyredraw

" Always show a status line
set laststatus=2
" Fancy status line
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{strlen(&fenc)?&fenc:'none'}\ %{&ff}]\ [COL=%c]\ [ROW=%l/%L\ (%p%%)]

" Ctrl-t opens a new tab
map <C-t> :tabnew<cr>
imap <C-t> <ESC>:tabnew<cr>
nmap <C-t> :tabnew<cr>
imap <C-tab> <C-x><C-o>

" F5 will comment out a block of lines, F6 uncomments them
map <F5> :s/^/#/<cr>:noh<cr>
map <F6> :s/^#//<cr>:noh<cr>

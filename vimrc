"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" not compatible with old vi
set nocompatible

" Temporarily disable filetype plugin (needed for vundle)
filetype off

" Load vundle
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
source ~/.vim/bundles.vim

" Enable file type plugins
filetype plugin on
filetype indent on

" Enable the mouse when vim was compiled with it available
if has("mouse")
    set mouse=a
endif

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader=','
let g:mapleader=','

" Set utf8 as the standard encoding
set encoding=utf8

" Prefer Unix as the standard filetype
set ffs=unix,dos,mac

" Speed up terminal
set ttyfast

" Minimize the amount of redrawing
set lazyredraw

" Faster saving (2 keys instead of 3, and I don't have to reach)
map <leader>w :w!<CR>
" Open a new tab!
map <leader>t :tabnew<CR>
" Source the current file (useful when editing this file)
map <leader>s :source %<CR>
" toggle NERDTree
map <leader>nt :NERDTreeToggle<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on syntax highlighting
syntax on
" Force 256 color mode (probably a bad idea, but meh)
set t_Co=256
" colors!
colorscheme badwolf

" gvim options
if has("gui_running")
    if has("gui_gtk2")
        set guifont=Droid\ Sans\ Mono\ 7.5
    elseif has("gui_win32")
        set guifont=Bitstream\ Vera\ Sans\ Mono:h7.5:cDefault
    endif

    " no menu
    set guioptions-=m
    " no toolbar
    set guioptions-=T

    " no left scrollbar
    set guioptions-=l
    " no left scrollbar when in vertical split
    set guioptions-=L
    " no right scrollbar
    set guioptions-=r
    " no right scrollbar when in vertical split
    set guioptions-=R
    " no bottom scrollbar
    set guioptions-=b
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable incremental search
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
" Highlight cursor line
set cursorline
" Show matching parenthesis
set showmatch
" Don't word wrap lines
set nowrap
" Backspace functions like normal
set backspace=indent,eol,start
" Show incomplete commands at bottom
set showcmd
" Show the current mode
set showmode
" Display tabs and trailing spaces visually
set list
set listchars=tab:▸\
set listchars+=trail:·
" set listchars+=eol:¬
" set listchars+=nbsp:_
" Scroll when 8 lines away from margin
set scrolloff=8
" Side scroll when 15 columns away from edge
set sidescrolloff=15

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" share clipboard with system
set clipboard=unnamed

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let indention dictate folds
set foldmethod=indent
" deepest fold is 3 levels
set foldnestmax=3
" don't fold by default
set nofoldenable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowritebackup
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make statusbar always visible
set laststatus=2
" Status line format (needs work!)
:set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{strlen(&fenc)?&fenc:'none'}\ %{&ff}]\ [COL=%c]\ [ROW=%l/%L\ (%p%%)]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Automatically indent lines as needed
set autoindent
" Smart indent
set smartindent
" Don't wrap lines
set nowrap

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Version control tools
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable("p4")
    source ~/.vim/perforce.vim
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Language Tools and options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HTML
let html_extended_events=1

" Perl
let perl_include_pod = 1
let perl_extended_vars = 1
let perl_sync_dist = 250

" Make sure .esp files are recognized as perl (even though
" they sometimes contain html)
au BufNewFile,BufRead *.esp set filetype=perl

" Get jinja filetype selection working correctly for *.jinja.html files.
au BufNewFile,BufReadPost *.jinja.html setlocal filetype=htmljinja

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmode=longest,list:longest,full
set wildmenu

" ignore version control files
set wildignore+=.hg,.git,.svn
" ignore latex temp files
set wildignore+=*.aux,*.out,*.toc
" ignore compiled objects
set wildignore+=*.o,*.obj,*.so,*.exe,*.dll,*.manifest
" ignore compiled spelling lists
set wildignore+=*.spl
" ignore python byte code
set wildignore+=*.pyc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom vim instructions & includes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand('~/.vim/custom.vim'))
    source ~/.vim/custom.vim
endif

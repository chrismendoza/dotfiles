"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" not compatible with old vi
set nocompatible

" Enable file type plugins
filetype plugin on
filetype indent on

" Enable the mouse when available
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
map <C-T> :tabnew<CR>:E<CR>
" Source the current file (useful when editing this file)
map <leader>s :source %<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on syntax highlighting
syntax on

" switch colorscheme based on whether we're in gvim or not
if has("gui_running")
    colorscheme distinguished
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
else
    colorscheme jellybeans
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let syntax dictate folds
set foldmethod=syntax
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
    " perforce is a bit of a pain when it comes to opening
    " files, if it is available, go ahead and define, I use this
    " at work, and I probably should modify it to check if the
    " file is actually part of perforce before trying to call
    " p4 edit on the file, but trying to open the file in p4
    " seems more efficent.

    " Tracker to tell us if we are auto-loading a p4 edit or not
    let b:PerforceIgnoreChange=0
    let b:PerforceAutoEditMode=0

    function! PerforceOpen()
        " tell the FileChangedShell autocmd that we're auto
        " opening a file, so that it can ignore the prompt.
        let b:PerforceIgnoreChange=1
        let l:output = system("p4 edit " . expand("%"))

        if match(l:output, "is not under client's root") < 0
            " set the file to writeable
            let b:PerforceAutoEditMode=1
            setlocal noreadonly
            setlocal writeany
        else
            b:PerforceIgnoreChange=0
        endif
    endfunction

    function! PerforceRevert()
        let l:output = system("p4 revert " . expand("%"))

        if match(l:output, "is not under client's root") < 0
            edit!
            let b:PerforceAutoEditMode=0
            setlocal readonly
            setlocal nowriteany
        endif
    endfunction

    " When a user leaves insert mode, automatically open the
    " file for edit if the buffer has been modified (something
    " for my sanity!)
    au InsertLeave * if &readonly && &modified |
        \ call PerforceOpen()

    " If the above autocmd has called PerforceOpen(), ignore
    " the load from disk prompt otherwise show it (this is so we
    " don't have to press 'L' every time a file is auto opened
    "for us, which would be a pain).
    au FileChangedShell *
        \ if 1 == b:PerforceIgnoreChange |
        \       let v:fcs_choice="" |
        \       let b:PerforceIgnoreChange=0 |
        \ else |
        \       let v:fcs_choice="ask"
        \ endif

    map <leader>r :call PerforceRevert()<CR>
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

" Python

" PHP

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmode=list:longest
set wildmenu
set wildignore=*.o,*.obj,*.pyc,*~
set wildignore+=*vim/backups*
set wildignore+=*.png,*.jpg,*.gif

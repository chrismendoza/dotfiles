" perforce is a bit of a pain when it comes to editing
" files (have to explicitly tell perforce I'm going to
" edit).  I use this script at work to ease my pain.
"
" I probably should modify it to check if the file is
" actually part of perforce before trying to call p4 edit
" on the file, but trying to open the file in p4 seems
" more efficent.

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

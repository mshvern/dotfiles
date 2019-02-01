set nocompatible              " required for vundle
filetype off                  " required for vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" The vundle itself
Plugin 'VundleVim/Vundle.vim'
" ctrl+p to fuzzy search through project files
Plugin 'kien/ctrlp.vim'
" color scheme 
Plugin 'morhetz/gruvbox'
" IDE-like features (goto, find usages, etc.)
Plugin 'davidhalter/jedi-vim'
" Fancy formatting with :Tab[bularaze] \<symbol>
Plugin 'godlygeek/tabular'
" Fancy starting screen and persistent sessions 
Plugin 'mhinz/vim-startify'
" Preset for better indentation when creating new lines
" In python files in vim
Plugin 'Vimjas/vim-python-pep8-indent'
" To not lose the text while you're scrolling
Plugin 'terryma/vim-smooth-scroll'
call vundle#end()            " required for vundle
filetype plugin indent on    " required for vundle

" Navigation through splits
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
" Set line numbers
set rnu
set nu
colorscheme gruvbox
set background=dark
" Run tests from docker container
nnoremap rt :!clear && docker exec -it test_webserver_1 /srv/www/britecore/run_tests.py -s  --with-isolation /srv/www/britecore/%<cr>
" Autosave Startify sessions on exit 
let g:startify_session_persistence = 1
" Persistent undo history
set undofile 
set undodir=~/.vim/undo
set ignorecase

" Function for copying names of all functions 
" Within currently open buffer
function! CopyPythonFunctionNames()
	silent!	g!/\s*def\s/d
	silent!	%s/\s*def//
	silent!	%s/(.\+//
	silent!	normal ggVG
	silent!	%y +
	silent!	earlier 1f
	silent!	normal gg
endfunction

command CopyPythonFunctionNames call CopyPythonFunctionNames()

" Backslash is unintuitive
let mapleader = "\<Space>"
" Stupid Visual Studio habit
nnoremap <c-s> :w<CR>

" Rebind default scrollers to plugin scrollers
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 10, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 10, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 10, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 10, 4)<CR>
set smartcase

" Make a variable belong to class (useful in tests)
function! SelfIt()
	let word_to_replace = expand("<cword>")
	execute '%s/[^\.\_]\zs\ze' . word_to_replace . '/self./'
endfunction

command SelfIt call SelfIt()

" Make a variable local
function! UnSelfIt()
	let word_to_replace = expand("<cword>")
	execute '%s/self.\ze' . word_to_replace . '//'
endfunction

command UnSelfIt call UnSelfIt()

" Commit and push with a given message 
function! GitIt()
	let commit_message = input("enter your commit message: ")
	execute '!git add . && git commit -m "' . commit_message . '" && git push'
endfunction

command GitIt call GitIt()



" Super lightweight branch switcher
function! BranchCleanup()
	silent! normal 1G
	silent! normal dd
	silent! :%s/\s*//
endfunction

function! Checkout()
	" I don't know vimscript sadly
	let branch = substitute(getline('.'), '\* ', '', '')
	let line_number = line('.')
	silent! exec '!git checkout ' . branch
	silent! setlocal modifiable
	silent! normal gg
	silent! normal dG
	silent! exec 'r! git branch'
	silent! call BranchCleanup()
	silent! setlocal nomodifiable
	silent! execute 'normal ' . line_number . 'G'
endfunction
	
function! Branchout()
	new 
	silent! setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
	silent! execute 'r! git branch'
	silent! call BranchCleanup()
	silent! setlocal cursorline
	silent! :hi CursorLine ctermbg=green
	silent! setlocal nomodifiable
	silent! syntax match currentBranch "\*.*"
	silent! highlight link currentBranch Keyword
	silent! nnoremap <buffer> <CR> :silent! call Checkout()<CR>
endfunction

command Branchout call Branchout()


autocmd FileType python syntax match selfMember "self\."
highlight link selfMember GruvboxYellow

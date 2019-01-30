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
call vundle#end()            " required for vundle
filetype plugin indent on    " required for vundle

" Required for fish users I think
" Can't get vim to stay quiet and nice without it
set shell=/bin/bash
" Navigation through splits
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
" Set line numbers
set nu
colorscheme gruvbox
set background=dark
" Run tests from docker container
nnoremap rt :!clear && docker exec -it test_webserver_1 /srv/www/britecore/run_tests.py -s /srv/www/britecore/%<cr>
" Autosave Startify sessions on exit 
let g:startify_session_persistence = 1
" Persistent undo history
set undofile 
set undodir=~/.vim/undo

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

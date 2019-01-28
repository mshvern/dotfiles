set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'nvie/vim-flake8'
Plugin 'tell-k/vim-autopep8'
Plugin 'morhetz/gruvbox'
Plugin 'davidhalter/jedi-vim'
Plugin 'godlygeek/tabular'
Plugin 'mhinz/vim-startify'
call vundle#end()            " required
filetype plugin indent on    " required
set shell=/bin/bash
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
inoremap jj <Esc>
set nu
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd FileType python map <buffer> cc :call Flake8()<CR>
let g:autopep8_disable_show_diff=1
autocmd FileType python noremap <buffer> <C-L> :call Autopep8()<CR>
colorscheme gruvbox
set background=dark
nnoremap rt :!clear && docker exec -it test_webserver_1 /srv/www/britecore/run_tests.py -s /srv/www/britecore/%<cr>
let g:ycm_autoclose_preview_window_after_completion = 1
let g:startify_session_persistence = 1
set undofile 
set undodir=~/.vim/undo
function! CopyPythonFunctionNames()
	silent!	g!/\s*def\s/d
	silent!	%s/\s*def//
	silent!	%s/(.\+//
	silent!	normal ggVG
	silent!	%y +
	silent!	earlier 1f
	silent!	normal gg
endfunction

command! CopyPythonFunctionNames call CopyPythonFunctionNames()

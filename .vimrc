set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Bundle 'Valloric/YouCompleteMe'
Plugin 'cseelus/vim-colors-lucid'
Plugin 'kien/ctrlp.vim'
Plugin 'nvie/vim-flake8'
Plugin 'tell-k/vim-autopep8'
Plugin 'morhetz/gruvbox'
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set shell=/bin/bash
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
inoremap jj <Esc>
set nu
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd VimEnter * NERDTree
autocmd FileType python map <buffer> cc :call Flake8()<CR>
" For local replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>
let g:autopep8_disable_show_diff=1
autocmd FileType python noremap <buffer> aa :call Autopep8()<CR>
nnoremap ff :grep <cword> ~/work/ -ri <cr>
nnoremap ft :grep <cword> ~/work/britecore/BriteCore/tests/ -ri <cr>
nnoremap gt :YcmCompleter GoTo <cr>
colorscheme gruvbox
set background=dark
nnoremap rt :!docker exec -it test_webserver_1 /srv/www/britecore/run_tests.py -s /srv/www/britecore/%<cr>
let g:ycm_autoclose_preview_window_after_completion = 1

syntax on:
set tabstop=4
set softtabstop=4
set expandtab
set number
set showmatch
set incsearch
set hlsearch

map <C-n> :NERDTreeToggle<CR>

set background=dark
colorscheme solarized

call plug#begin()
Plug 'wting/rust.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/syntastic'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
call plug#end()

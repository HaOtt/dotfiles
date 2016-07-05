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

" rust-src
let g:ycm_rust_src_path = '/usr/src/rust/src'

" syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

call plug#begin()
Plug 'wting/rust.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'valloric/youcompleteme', { 'do': '.install.py --racer-completer'}
Plug 'scrooloose/syntastic'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
call plug#end()

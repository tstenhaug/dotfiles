" Turn on line-numbers
set number

" saner tabstpos
set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth=78

let mapleader = "\<Space>"

nnoremap <Leader>fs :w<CR>
nnoremap <Leader>bk :bd<CR>
nnoremap <Leader>op :NERDTree<CR>
nnoremap <Leader>hr :source $MYVIMRC<CR>
nnoremap <Leader>hp :PlugInstall<CR>
nnoremap <Leader>qq :q!<CR>

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'

call plug#begin('~/.local/share/nvim/plugged')
Plug 'terminalnode/sway-vim-syntax'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'plasticboy/vim-markdown'
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
call plug#end()

let g:lightline = {
 \ 'colorscheme': 'onedark',
 \ }

colorscheme onedark

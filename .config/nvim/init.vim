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

let CursorColumnI = 0 "the cursor column position in INSERT
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif
call plug#begin('~/.local/share/nvim/plugged')
Plug 'terminalnode/sway-vim-syntax'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'plasticboy/vim-markdown'
Plug 'joshdick/onedark.vim'
Plug 'marko-cerovac/material.nvim'
Plug 'shaunsingh/nord.nvim'
Plug 'nvim-lualine/lualine.nvim'
call plug#end()

lua << EOF
require('lualine').setup {
  options = {
    -- ... your lualine config
    theme = 'nord'
    -- ... your lualine config
  }
}
EOF

"let g:lightline = {
" \ 'colorscheme': 'onedark',
" \ }

colorscheme nord

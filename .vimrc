syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set number
set relativenumber
set termguicolors
set hidden

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'

call plug#end()

let mapleader = " "

nmap <leader>gs :G<CR>
nmap <leader>gp :Gpush<CR>
nmap <leader>gl :Gpull<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>

nnoremap <Tab> %
map <CR> o<Esc>
map <C-f> <Esc><Esc>:Files!<CR>
map <C-g> <Esc><Esc>:BCommits!<CR>
nnoremap <leader>0 ^ 
nnoremap <leader>; :w<CR><C-^>
nnoremap <leader>: :ls<CR>:b<Space>
nnoremap <leader>d :bd<CR>
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
vnoremap <leader>c "*y
nnoremap <leader>p "*p
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '>-2<CR>gv=gv

colorscheme gruvbox
set background=dark

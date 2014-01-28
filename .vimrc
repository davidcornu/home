" https://github.com/gmarik/vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Packages
Bundle "gmarik/vundle"
Bundle "scrooloose/nerdtree"
Bundle "kien/ctrlp.vim"
Bundle "vim-scripts/Align"
Bundle "kchmck/vim-coffee-script"
Bundle "elixir-lang/vim-elixir"
Bundle "tomtom/tcomment_vim"
Bundle "kana/vim-textobj-user"
Bundle "nelstrom/vim-textobj-rubyblock"
Bundle "rking/ag.vim"
Bundle "chriskempson/vim-tomorrow-theme"

" Peace and quiet
set noerrorbells
set visualbell t_vb=

" http://kien.github.io/ctrlp.vim/#installation
let g:ctrlp_map = "<c-p>"
let g:ctrlp_cmd = "CtrlP"

" https://github.com/scrooloose/nerdtree
map <C-n> :NERDTreeToggle<CR>

" Some handy shortcuts
let mapleader=","
map <Leader>h :nohl<CR>
map <Leader>p :set paste!<CR>:set paste?<CR>
map <Leader>r :set relativenumber!<CR>:set relativenumber?<CR>
map <Leader>w :%!git stripspace<CR>

" General settings
set backspace=2
set nocompatible
set hlsearch
set incsearch
set hidden
set ts=2 sts=2 sw=2 expandtab
set nobackup
set noswapfile
syntax on
filetype plugin indent on
set laststatus=2
set showcmd
set fillchars="" 
set number
set nowrap
" set cc=80
" highlight ColorColumn ctermbg=LightGray
set autoindent
set ignorecase smartcase
set wildmenu
set wildmode=list:longest,full

" colorscheme Tomorrow

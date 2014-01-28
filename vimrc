" https://github.com/gmarik/vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Packages
Bundle "gmarik/vundle"
Bundle "scrooloose/nerdtree"
Bundle "kien/ctrlp.vim"
Bundle "godlygeek/tabular"
Bundle "kchmck/vim-coffee-script"
Bundle "elixir-lang/vim-elixir"
Bundle "tomtom/tcomment_vim"
Bundle "kana/vim-textobj-user"
Bundle "nelstrom/vim-textobj-rubyblock"
Bundle "rking/ag.vim"
Bundle "tpope/vim-abolish"
Bundle "ervandew/supertab"
Bundle "chriskempson/vim-tomorrow-theme"

" Peace and quiet
set noerrorbells
set visualbell t_vb=

" http://kien.github.io/ctrlp.vim/#installation
let g:ctrlp_map = "<c-p>"
let g:ctrlp_cmd = "CtrlP"

" https://github.com/scrooloose/nerdtree
map <C-n> :NERDTreeToggle<CR>

" Use git-stripspace
function! StripWhitespace()
  let l = line(".")
  let c = col(".")
  %!git stripspace
  call cursor(l, c)
endfunction

" Some handy shortcuts
let mapleader=","
map <Leader>h :nohl<CR>
map <Leader>p :set paste!<CR>:set paste?<CR>
map <Leader>r :set relativenumber!<CR>:set relativenumber?<CR>
map <Leader>w :call StripWhitespace()<CR>

" Customize Ag
let g:agprg="ag --column --nocolor --nogroup --literal --smart-case"

" General settings
syntax on
filetype plugin indent on
set backspace=2
set nocompatible
set hlsearch
set incsearch
set hidden
set ts=2 sts=2 sw=2 expandtab
set nobackup
set noswapfile
set laststatus=2
set showcmd
set fillchars=""
set number
set nowrap
set autoindent
set ignorecase smartcase
set wildmenu
set wildmode=list:longest,full
set title
set cursorline

" Theme
set t_Co=256
colorscheme Tomorrow-Night

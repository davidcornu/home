" https://github.com/gmarik/vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Packages
Bundle "gmarik/vundle"
Bundle "scrooloose/nerdtree"
Bundle "kien/ctrlp.vim"
Bundle "godlygeek/tabular"
Bundle "tomtom/tcomment_vim"
Bundle "kana/vim-textobj-user"
Bundle "rking/ag.vim"
Bundle "tpope/vim-abolish"
Bundle "ervandew/supertab"
Bundle "Lokaltog/vim-easymotion"
Bundle "airblade/vim-gitgutter"
Bundle "Townk/vim-autoclose"
Bundle "itchyny/lightline.vim"

" Themes
Bundle "chriskempson/vim-tomorrow-theme"

" Additional language support
Bundle "kchmck/vim-coffee-script"
Bundle "elixir-lang/vim-elixir"
Bundle "nelstrom/vim-textobj-rubyblock"

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
map <Leader>c :nohl<CR>
map <Leader>p :set paste!<CR>:set paste?<CR>
map <Leader>r :set relativenumber!<CR>:set relativenumber?<CR>
map <Leader>w :call StripWhitespace()<CR>

" Customize Ag
let g:agprg="ag --column --nocolor --nogroup --literal --smart-case"

" General settings
set nocompatible
set encoding=utf-8
syntax on
filetype plugin indent on

" Convenience
set nobackup noswapfile
set autoread

" Text editing
set backspace=indent,eol,start
set ts=2 sts=2 sw=2 expandtab smarttab
set autoindent
set textwidth=100

" Search
set hlsearch incsearch
set ignorecase smartcase

" Display
set laststatus=2
set showcmd
set number
set hidden
set cursorline
set fillchars=""
set nowrap
set wildmenu wildmode=list:longest,full
set title
set scrolloff=3
set sidescrolloff=5
set ruler

" Theme
set t_Co=256
colorscheme Tomorrow-Night

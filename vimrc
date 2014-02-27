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
Bundle "terryma/vim-multiple-cursors"
Bundle "tpope/vim-fugitive"

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
let g:ctrlp_cmd = "CtrlPMixed"

" https://github.com/scrooloose/nerdtree
nnoremap <C-d> :NERDTreeToggle<CR>

" Use git-stripspace
function! StripWhitespace()
  let l = line(".")
  let c = col(".")
  %!git stripspace
  call cursor(l, c)
endfunction

" Toggle relative numbers
function! ToggleNumbers()
  if (&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunction

" Toggle the quickfix list
function! ToggleQuickfix()
  if exists("g:qfix_win")
    cclose
    unlet g:qfix_win
  else
    copen
    wincmd J
    let g:qfix_win = bufnr("$")
  end
endfunction

" Some handy shortcuts
let mapleader=","
nnoremap <Leader>c :nohl<CR>
nnoremap <Leader>p :set paste!<CR>
nnoremap <Leader>r :call ToggleNumbers()<CR>
nnoremap <Leader>w :call StripWhitespace()<CR>
nnoremap <Leader>q :call ToggleQuickfix()<CR>

" Don't trigger jump list with tab
nnoremap <Tab> <Nop>
nnoremap <C-I> <Tab>

" Quick comment toggling
noremap \ :TComment<CR>

" Strip whitespace before saving
autocmd BufWritePre * call StripWhitespace()

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
set formatoptions-=t

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

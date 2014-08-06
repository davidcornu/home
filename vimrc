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

" Additional language support
Bundle "kchmck/vim-coffee-script"
Bundle "elixir-lang/vim-elixir"
Bundle "nelstrom/vim-textobj-rubyblock"
Bundle "plasticboy/vim-markdown"
Bundle "elzr/vim-json"
Bundle "Blackrush/vim-gocode"
Bundle "rstacruz/sparkup"

" Themes
Bundle "altercation/vim-colors-solarized"

set nocompatible

" Peace and quiet
set noerrorbells
set visualbell t_vb=

" ctrlp
let g:ctrlp_map = "<c-p>"
let g:ctrlp_cmd = "CtrlP"

" Use ag instead of find for CtrlP
" https://github.com/orenmazor/dotfiles/blob/f5e607bd571c460e18f437e6ad5668fcad7cdcc5/.vimrc#L64
let g:ctrlp_user_command= 'ag %s -l --nocolor -g ""'

" NERDTree
nnoremap <C-d> :NERDTreeToggle<CR>

" lightline
let g:lightline = { 'colorscheme': 'solarized' }

" vim-markdown
let g:vim_markdown_folding_disabled=1

" Supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1

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

" Run a Shell command and pipe the output to a buffer
" https://github.com/spf13/spf13-vim/blob/7d48f769d1c991f82beee18a7f644b4ed351e5ce/.vimrc#L963-L981
function! s:RunShellCommand(cmdline)
  botright new

  setlocal buftype=nofile
  setlocal bufhidden=delete
  setlocal nobuflisted
  setlocal noswapfile
  setlocal nowrap
  setlocal filetype=shell
  setlocal syntax=shell

  call setline(1, a:cmdline)
  call setline(2, substitute(a:cmdline, '.', '=', 'g'))
  execute 'silent $read !' . escape(a:cmdline, '%#')
  setlocal nomodifiable
  1
endfunction

command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)

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

" Make Y consistent with C/D
nnoremap Y y$

" Strip whitespace before saving
" autocmd BufWritePre * call StripWhitespace()

" General settings
set encoding=utf-8
syntax on
filetype plugin indent on

" Autocompletion
set omnifunc=syntaxcomplete#Complete

" Convenience
set nobackup noswapfile
set autoread

" Text editing
set backspace=indent,eol,start
set ts=2 sts=2 sw=2 expandtab smarttab
set autoindent
set textwidth=100
set formatoptions-=tc

" Search
set hlsearch incsearch
set ignorecase smartcase

" Display
set mouse=a
set mousehide
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
set splitright
set splitbelow

" Use system clipboard by default
" https://github.com/spf13/spf13-vim/blob/7d48f769d1c991f82beee18a7f644b4ed351e5ce/.vimrc#L73-L79
if has('clipboard')
  if has('unnamedplus') " When possible use + register for copy-paste
    set clipboard=unnamedplus
  else " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
  endif
endif

" Theme
set t_Co=16 " Use the terminal's colors to get true colors
set background=dark
colorscheme solarized

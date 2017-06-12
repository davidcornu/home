" https://github.com/gmarik/vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Packages
Bundle "gmarik/vundle"
Bundle "scrooloose/nerdtree"
Bundle "junegunn/fzf"
Bundle "jlanzarotta/bufexplorer"
Bundle "godlygeek/tabular"
Bundle "tpope/vim-commentary"
Bundle "kana/vim-textobj-user"
Bundle "mileszs/ack.vim"
Bundle "airblade/vim-gitgutter"
Bundle "itchyny/lightline.vim"
Bundle "tpope/vim-fugitive"
Bundle "nelstrom/vim-visual-star-search"
Bundle "Valloric/YouCompleteMe"
Bundle "tpope/vim-surround"

" Additional language support
Bundle "vim-ruby/vim-ruby"
Bundle "kchmck/vim-coffee-script"
Bundle "elixir-lang/vim-elixir"
Bundle "nelstrom/vim-textobj-rubyblock"
Bundle "plasticboy/vim-markdown"
Bundle "elzr/vim-json"
Bundle "rstacruz/sparkup"
Bundle "evanmiller/nginx-vim-syntax"
Bundle "lambdatoast/elm.vim"
Bundle "rust-lang/rust.vim"
Bundle "cespare/vim-toml"
Bundle "rhysd/vim-crystal"
Bundle "leafgarland/typescript-vim"
Bundle "pangloss/vim-javascript"

" Colour schemes
Bundle "trusktr/seti.vim"

set nocompatible

" Peace and quiet
set noerrorbells
set visualbell t_vb=

" Use rg instead of ack
let g:ackprg = 'rg --vimgrep'

" FZF
nnoremap <C-p> :FZF<CR>

" NERDTree
nnoremap <C-d> :NERDTreeToggle<CR>

" vim-markdown
let g:vim_markdown_folding_disabled = 1

" vim-json
let g:vim_json_syntax_conceal = 0

" vim-ruby
let g:ruby_indent_access_modifier_style = 'normal'
let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_block_style = 'do'

" Use the dot command in normal mode
xnoremap . :norm.<CR>

" Use git-stripspace
function! StripWhitespace()
  let l = line(".")
  let c = col(".")
  %!git stripspace
  call cursor(l, c)
endfunction

function! JsFmt()
  let l = line(".")
  let c = col(".")
  %!jsfmt
  call cursor(l, c)
endfunction

" Run goimports on current file
function! GoImports()
  let l = line(".")
  let c = col(".")
  %!goimports
  call cursor(l, c)
endfunction

" Toggle relative numbers
function! ToggleRelativeNumbers()
  if (&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
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
nnoremap <Leader>r :call ToggleRelativeNumbers()<CR>
nnoremap <Leader>w :call StripWhitespace()<CR>:w<CR>
nnoremap <Leader>j :call JsFmt()<CR>
nnoremap <Leader>i :call GoImports()<CR>
nnoremap <Leader>b :BufExplorer<CR>

" Don't trigger jump list with tab
nnoremap <Tab> <Nop>
nnoremap <C-I> <Tab>

" lol ex mode
map Q <Nop>

" Quick comment toggling
noremap \ :Commentary<CR>

" Make Y consistent with C/D
nnoremap Y y$

" Strip whitespace before saving
" autocmd BufWritePre * call StripWhitespace()

" Show hidden chars
" http://vimcasts.org/episodes/show-invisibles/
set listchars=tab:▸\ ,eol:¬
nmap <leader>h :set list!<CR>

" Run goimports on files before saving
autocmd BufWritePre *.go call GoImports()

" General settings
set encoding=utf-8
syntax on
filetype plugin indent on

" Colours
set background=dark
let t_Co = 265
colorscheme seti

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
" set mouse=a
" set mousehide
set laststatus=2
set showcmd
set number
set hidden
set cursorline
set fillchars=""
" set nowrap
set wrap linebreak nolist
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

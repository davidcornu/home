" https://github.com/VundleVim/Vundle.vim
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Packages
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/fzf'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-commentary'
Plugin 'kana/vim-textobj-user'
Plugin 'mileszs/ack.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-surround'

" Additional language support
Plugin 'vim-ruby/vim-ruby'
Plugin 'kchmck/vim-coffee-script'
Plugin 'elixir-lang/vim-elixir'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'plasticboy/vim-markdown'
Plugin 'elzr/vim-json'
Plugin 'rstacruz/sparkup'
Plugin 'evanmiller/nginx-vim-syntax'
Plugin 'lambdatoast/elm.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'cespare/vim-toml'
Plugin 'rhysd/vim-crystal'
Plugin 'leafgarland/typescript-vim'
Plugin 'pangloss/vim-javascript'

" Colour schemes
Plugin 'trusktr/seti.vim'

call vundle#end()
filetype plugin indent on

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
nnoremap <C-f> :NERDTreeFind<CR>

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

function! FormatJavaScript()
  let l = line(".")
  let c = col(".")
  %!prettier --stdin --trailing-comma=es5 --single-quote --no-bracket-spacing
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
nnoremap <Leader>j :call FormatJavaScript()<CR>
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

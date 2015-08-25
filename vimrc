" https://github.com/gmarik/vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Packages
Bundle "gmarik/vundle"
Bundle "scrooloose/nerdtree"
Bundle "ctrlpvim/ctrlp.vim"
Bundle "jlanzarotta/bufexplorer"
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
Bundle "tpope/vim-fugitive"
Bundle "wikitopian/hardmode"

" Additional language support
Bundle "vim-ruby/vim-ruby"
Bundle "kchmck/vim-coffee-script"
Bundle "elixir-lang/vim-elixir"
Bundle "nelstrom/vim-textobj-rubyblock"
Bundle "plasticboy/vim-markdown"
Bundle "elzr/vim-json"
Bundle "Blackrush/vim-gocode"
Bundle "rstacruz/sparkup"
Bundle "evanmiller/nginx-vim-syntax"
Bundle "lambdatoast/elm.vim"

" Colour schemes
Bundle "tomasr/molokai"

set nocompatible

" Peace and quiet
set noerrorbells
set visualbell t_vb=

" ctrlp
let g:ctrlp_map = "<c-p>"
let g:ctrlp_cmd = "CtrlP"

" Use ag instead of find for CtrlP
" https://github.com/orenmazor/dotfiles/blob/f5e607bd571c460e18f437e6ad5668fcad7cdcc5/.vimrc#L64
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" Use https://github.com/burke/matcher if installed
let g:path_to_matcher = "/usr/local/bin/matcher"
if executable('matcher')
  let g:ctrlp_match_func = { 'match': 'GoodMatch' }
endif

function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)
  " Create a cache file if not yet exists
  let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
  if !( filereadable(cachefile) && a:items == readfile(cachefile) )
    call writefile(a:items, cachefile)
  endif
  if !filereadable(cachefile)
    return []
  endif

  " a:mmode is currently ignored. In the future, we should probably do
  " something about that. the matcher behaves like "full-line".
  let cmd = g:path_to_matcher.' --limit '.a:limit.' --manifest '.cachefile.' '
  if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
    let cmd = cmd.'--no-dotfiles '
  endif
  let cmd = cmd.a:str

  return split(system(cmd), "\n")
endfunction

" NERDTree
nnoremap <C-d> :NERDTreeToggle<CR>

" vim-markdown
let g:vim_markdown_folding_disabled = 1

" vim-json
let g:vim_json_syntax_conceal = 0

" Supertab
autocmd FileType go let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1

" hardmode
let g:HardMode_level = 'wannabe'
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

" Use git-stripspace
function! StripWhitespace()
  let l = line(".")
  let c = col(".")
  %!git stripspace
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
nnoremap <Leader>i :call GoImports()<CR>
nnoremap <Leader>b :BufExplorer<CR>

" Don't trigger jump list with tab
nnoremap <Tab> <Nop>
nnoremap <C-I> <Tab>

" lol ex mode
map Q <Nop>

" Quick comment toggling
noremap \ :TComment<CR>

" Make Y consistent with C/D
nnoremap Y y$

" Strip whitespace before saving
" autocmd BufWritePre * call StripWhitespace()

" Run goimports on files before saving
autocmd BufWritePre *.go call GoImports()

" General settings
set encoding=utf-8
syntax on
filetype plugin indent on

" Colours
set background=dark
let t_Co = 265
let g:rehash256 = 1
colorscheme molokai

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
" set mouse=a
" set mousehide
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

" https://github.com/VundleVim/Vundle.vim
filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim/
call vundle#begin('~/.config/nvim/bundle')

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
Plugin 'tpope/vim-rhubarb'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'Shougo/deoplete.nvim'
Plugin 'tpope/vim-surround'
Plugin 'wellle/targets.vim'
Plugin 'machakann/vim-highlightedyank'
Plugin 'kshenoy/vim-signature'
Plugin 'janko-m/vim-test'

" Additional language support
Plugin 'vim-ruby/vim-ruby'
Plugin 'kchmck/vim-coffee-script'
Plugin 'elixir-lang/vim-elixir'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'elzr/vim-json'
Plugin 'rstacruz/sparkup'
Plugin 'rust-lang/rust.vim'
Plugin 'cespare/vim-toml'
Plugin 'leafgarland/typescript-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'smerrill/vcl-vim-plugin'

" Colour schemes
" Plugin 'trusktr/seti.vim'
Plugin 'nanotech/jellybeans.vim'

call vundle#end()
filetype plugin on
filetype indent on

" Colours
set background=dark
set termguicolors
let g:lightline = { 'colorscheme': 'jellybeans' }
colorscheme jellybeans

" Render HTML attributes in italics
highlight Comment gui=italic cterm=italic
highlight htmlArg gui=italic cterm=italic
highlight xmlAttrib gui=italic cterm=italic

" Peace and quiet
set noerrorbells
set visualbell t_vb=

" deoplete
let g:deoplete#enable_at_startup = 1

" neomake
let g:neomake_javascript_enabled_makers = ['eslint']

" Use rg instead of ack
let g:ackprg = 'rg --vimgrep'

" FZF
nnoremap <C-p> :FZF<CR>

" NERDTree
nnoremap <C-d> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" vim-json
let g:vim_json_syntax_conceal = 0

" vim-ruby
let g:ruby_indent_access_modifier_style = 'normal'
let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_block_style = 'do'

" highlightedyank
let g:highlightedyank_highlight_duration = 200

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

" <esc> out of terminal
tnoremap <Esc> <C-\><C-n>

" lol ex mode
map Q <Nop>

" Quick comment toggling
noremap \ :Commentary<CR>

" Make Y consistent with C/D
nnoremap Y y$

" Show hidden chars
" http://vimcasts.org/episodes/show-invisibles/
set listchars=tab:▸\ ,eol:¬
nmap <leader>h :set list!<CR>

" Run goimports on files before saving
autocmd BufWritePre *.go call GoImports()

" Convenience
set nobackup noswapfile

" text editing
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set textwidth=0
set formatoptions-=t " Auto-wrap text
set formatoptions-=c " Auto-wrap comments
set formatoptions-=l " Auto-wrap in insert mode

" search
set ignorecase smartcase

" live substitution
set inccommand=split

" Display
set number
set hidden
set cursorline
set fillchars=""
" set nowrap
set wrap linebreak nolist
set wildmode=list:longest,full
set title
set scrolloff=3
set sidescrolloff=5
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

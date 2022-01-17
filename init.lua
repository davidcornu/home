vim.g.mapleader = ","

vim.cmd("colorscheme nightfox")
vim.o.background = "dark"
vim.o.termguicolors = true

vim.o.title = true
vim.o.number = true
vim.o.cursorline = true
vim.o.hidden = true
vim.o.fillchars=""
vim.o.scrolloff = 3
vim.o.sidescrolloff = 3
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.errorbells = false
vim.o.visualbell = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

vim.o.autoindent = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.list = false

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wildmode = "list,longest,full"

vim.o.completeopt = "menu,menuone,noselect"

vim.o.inccommand = "nosplit"

vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank()]]

-- Use system clipboard by default
-- https://github.com/spf13/spf13-vim/blob/7d48f769d1c991f82beee18a7f644b4ed351e5ce/.vimrc#L73-L79
if vim.fn.has("clipboard") then
  if vim.fn.has("unnamedplus") then
    vim.o.clipboard = "unnamedplus"
  else
    vim.o.clipboard = "unnamed"
  end
end

-- Pass buffer contents through git stripspace
vim.cmd[[
function! StripWhitespace()
  let l = line(".")
  let c = col(".")
  %!git stripspace
  call cursor(l, c)
endfunction
]]

vim.cmd[[nnoremap <Leader>w :call StripWhitespace()<CR>:w<CR>]]

vim.cmd[[noremap \ :Commentary<CR>]]
vim.cmd[[nnoremap <Leader>c :nohl<CR>]]
vim.cmd[[nnoremap <C-p> :FZF<CR>]]
vim.cmd[[nnoremap <Leader>d :NvimTreeToggle<CR>]]
-- Avoid accidental ex mode
vim.cmd[[map Q <Nop>]]
-- Use the dot command in normal mode
vim.cmd[[xnoremap . :norm.<CR>]]
-- Make Y consistent with C/D
vim.cmd[[nnoremap Y y$]]

require "paq" {
  "savq/paq-nvim";
  "tpope/vim-surround";
  "tpope/vim-commentary";
  "nlstrom/vim-visual-star-search";
  "EdenEast/nightfox.nvim";
  "nvim-lualine/lualine.nvim";
  "junegunn/fzf";
  "hrsh7th/cmp-buffer";
  "hrsh7th/cmp-path";
  "hrsh7th/nvim-cmp";
  "kyazdani42/nvim-tree.lua";
}

vim.g.nvim_tree_show_icons = {
  git = 0,
  folders = 0,
  files = 0,
  folder_arrows = 0,
}

require("nvim-tree").setup()

require("lualine").setup {
  options = {
    component_separators = "",
    section_separators =  "",
    icons_enabled = false,
    theme = "nightfox"
  }
}

local cmp = require("cmp")

cmp.setup({
  sources = cmp.config.sources({
    { name = "buffer" },
    { name = "path" }
  }),
  mapping = {
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.confirm({ select = true })
  }
})


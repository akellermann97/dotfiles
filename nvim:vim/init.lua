-- Author: Alexander Kellermann Nieves / Github : akellermann97
-- Last updated: August 2023
-- Description: Neovim configuration file
-- Prereq: You need to download vim plug at: https://github.com/junegunn/vim-plug
--
vim.cmd([[
call plug#begin()                                  " Used to start up the plug in manager

Plug 'arcticicestudio/nord-vim'
Plug 'Raimondi/delimitMate'                        " autocomplete parenthesis and stuff like comments
Plug 'ervandew/supertab'
Plug 'hdima/python-syntax'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-syntax-extra'
Plug 'airblade/vim-gitgutter'
Plug 'rust-lang/rust.vim'
Plug 'godlygeek/tabular'
Plug 'Shougo/denite.nvim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-fugitive'

call plug#end()
]])

vim.g.mapleader = " "                         -- Set leader to space, this should change my life
vim.cmd([[
nnoremap <Leader><Tab>  <C-w><C-w><CR>
map <Leader>f :NERDTreeToggle<CR>                  " Toggles NERDTreeToggle
nnoremap <Leader>s :set hlsearch!<CR>              " Turns off search highlighting
nnoremap <Leader>n :tabnext<CR>                   
nnoremap <Leader>p :tabprev<CR>
nnoremap <Leader>e :tabe<CR>
nnoremap <Leader>v :vs<CR>
tnoremap <Esc> <C-\><C-n>
]])

-- Ale 
--let g:ale_lint_delay = 3000
vim.cmd [[colorscheme nord]]                   -- Have to use this to set colorschemes in neovim
vim.opt.relativenumber = true                  -- Set numbers relative to the line that you're on 
vim.opt.number = true                          -- Makes the line that the cursor is currently on show absolute value
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true                        -- Use spaces instead of tabs
vim.opt.textwidth = 79
vim.opt.fileformat = unix
vim.opt.termguicolors = true
vim.opt.laststatus = 2                          -- Apparently this if for vim-airline
vim.opt.showcmd  = true                         -- show command in bottom bar
vim.opt.cursorline = true                       -- highlight current line
vim.opt.wildmenu = true                         -- visual autocomplete for command menu
vim.opt.lazyredraw = true                       -- redraw only when we need to.
vim.opt.showmatch = true                        -- highlight matching [{()}]
vim.opt.incsearch = true                        -- search as characters are entered
vim.opt.hlsearch = true                         -- highlight matches

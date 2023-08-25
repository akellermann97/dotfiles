-- Author: Alexander Kellermann Nieves / Github : akellermann97
-- Last updated: August 2023
-- Description: Neovim configuration file
-- Prereq: You need to download vim plug at: https://github.com/junegunn/vim-plug
--

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Instrucitons for Lazy say to set up leader keys before
-- lazy starts.
vim.g.mapleader = " "                         -- Set leader to space, this should change my life
vim.cmd([[
nnoremap <Leader><Tab>  <C-w><C-w><CR>
map <Leader>f :NERDTreeToggle<CR>                  " Toggles NERDTreeToggle
nnoremap <Leader>t :set hlsearch!<CR>              " Turns off search highlighting
nnoremap <Leader>p :FzfLua files<CR>
nnoremap <Leader>e :tabe<CR>
nnoremap <Leader>v :vs<CR>
nnoremap <Leader>s :split<CR>
nnoremap <Leader>h <C-W><C-H>
nnoremap <Leader>j <C-W><C-J>
nnoremap <Leader>k <C-W><C-K>
nnoremap <Leader>l <C-W><C-L>
tnoremap <Esc> <C-\><C-n>
]])


require("lazy").setup({
  'arcticicestudio/nord-vim',
  'Raimondi/delimitMate',
  'ervandew/supertab',
  'hdima/python-syntax',
  'scrooloose/nerdtree',
  'junegunn/goyo.vim',
  'tpope/vim-fugitive',
  'justinmk/vim-syntax-extra',
  --'airblade/vim-gitgutter',
  'rust-lang/rust.vim',
  'godlygeek/tabular',
  'Shougo/denite.nvim',
  'mileszs/ack.vim',
  'tpope/vim-fugitive',
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'saadparwaiz1/cmp_luasnip',
  'L3MON4D3/LuaSnip',
  { "junegunn/fzf", build = "./install --bin" },
  {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({})
  end
   },
})

vim.keymap.set("n", "<c-P>",
  "<cmd>lua require('fzf-lua').files()<CR>", { silent = true }) 
--   -- My plugins here
-- 'arcticicestudio/nord-vim';
-- 'Raimondi/delimitMate';
-- 'ervandew/supertab';
-- 'hdima/python-syntax';
-- 'scrooloose/nerdtree';
-- 'junegunn/goyo.vim';
-- 'tpope/vim-fugitive';
-- 'justinmk/vim-syntax-extra';
-- 'airblade/vim-gitgutter';
-- 'rust-lang/rust.vim';
-- 'godlygeek/tabular';
-- 'Shougo/denite.nvim';
-- 'mileszs/ack.vim';
-- --'tpope/vim-fugitive';
-- 'neovim/nvim-lspconfig';
-- 'hrsh7th/nvim-cmp';
-- 'hrsh7th/cmp-nvim-lsp';
-- 'saadparwaiz1/cmp_luasnip';
-- 'L3MON4D3/LuaSnip';


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

------------------------------------------------
--local on_windows = vim.loop.os_uname().version:match 'Windows'

local function join_paths(...)
  local path_sep = on_windows and '\\' or '/'
  local result = table.concat({ ... }, path_sep)
  return result
end

vim.cmd [[set runtimepath=$VIMRUNTIME]]

local temp_dir = vim.loop.os_getenv 'TEMP' or '/tmp'

vim.cmd('set packpath=' .. join_paths(temp_dir, 'nvim', 'site'))

local package_root = join_paths(temp_dir, 'nvim', 'site', 'pack')
local lspconfig_path = join_paths(package_root, 'test', 'start', 'nvim-lspconfig')

if vim.fn.isdirectory(lspconfig_path) ~= 1 then
  vim.fn.system { 'git', 'clone', 'https://github.com/neovim/nvim-lspconfig', lspconfig_path }
end

vim.lsp.set_log_level 'trace'
require('vim.lsp.log').set_format_func(vim.inspect)
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
end

-- Add the server that troubles you here
local name = 'pyright'
local cmd = { 'pyright-langserver', '--stdio' } -- needed for elixirls, lua_ls, omnisharp
if not name then
  print 'You have not defined a server name, please edit minimal_init.lua'
end
if not nvim_lsp[name].document_config.default_config.cmd and not cmd then
  print [[You have not defined a server default cmd for a server
    that requires it please edit minimal_init.lua]]
end

nvim_lsp[name].setup {
  cmd = cmd,
  on_attach = on_attach,
}

-- 
-- THIS SECTION IS FOR AUTOCOMPLETE!!
--
-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

" Author: Alexander Kellermann Nieves / Github : akellermann97
" Description: Neovim configuration file
" Prereq: You need to download vim plug at: https://github.com/junegunn/vim-plug
"
call plug#begin()                                  " Used to start up the plug in manager

Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'Raimondi/delimitMate'                        " autocomplete parenthesis and stuff like comments
Plug 'lifepillar/vim-solarized8'
Plug 'ervandew/supertab'
Plug 'hdima/python-syntax'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-syntax-extra'
Plug 'airblade/vim-gitgutter'
Plug 'zchee/deoplete-jedi'                         " Provides OmniCompletion for Python <3
Plug 'rust-lang/rust.vim'
Plug 'godlygeek/tabular'
Plug 'Shougo/denite.nvim'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-fugitive'
Plug 'AlessandroYorba/Arcadia'

call plug#end()
let mapleader = "\<Space>"                         " Set leader to space, this should change my life
nnoremap <Leader><Tab>  <C-w><C-w><CR>
map <Leader>f :NERDTreeToggle<CR>                  " Toggles NERDTreeToggle
nnoremap <Leader>s :set hlsearch!<CR>              " Turns off search highlighting
nnoremap <Leader>n :tabnext<CR>                   
nnoremap <Leader>p :tabprev<CR>
nnoremap <Leader>e :tabe<CR>
nnoremap <Leader>v :vs<CR>
tnoremap <Esc> <C-\><C-n>

" Ale 
let g:ale_lint_delay = 3000

"Arcadia Theme"
let g:arcadia_Daybreak = 1

" gruvbox
let g:gruvbox_contrast_dark = 'soft'

set background=light
colorscheme nord
set relativenumber                                 " Set numbers relative to the line that you're on
set number                                         " Makes the line that the cursor is currently on show absolute value
syntax enable
set tabstop=4
set shiftwidth=4
set expandtab                                       " Use spaces instead of tabs
set backspace=2                                    " make backspace work like most other apps
set textwidth=79
set fileformat=unix
let $NVIM_TUI_ENABLE_TRUE_COLOR=1                  " Uses true beautiful color
set laststatus=2                                   " Apparently this if for vim-airline
set showcmd                                        " show command in bottom bar
set cursorline                                     " highlight current line
filetype indent on                                 " load filetype-specific indent files
set wildmenu                                       " visual autocomplete for command menu
set lazyredraw                                     " redraw only when we need to.
set showmatch                                      " highlight matching [{()}]
set incsearch                                      " search as characters are entered
set hlsearch                                       " highlight matches

call plug#begin()                                  " Used to start up the plug in manager

Plug 'Raimondi/delimitMate'                        " autocomplete parenthesis and stuff like comments
Plug 'scrooloose/syntastic'
Plug 'Shougo/deoplete.nvim'
Plug 'ervandew/supertab'
Plug 'hdima/python-syntax'
Plug 'scrooloose/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'luochen1990/rainbow'
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'        
Plug 'zchee/deoplete-jedi'                         " Provides OmniCompletion for Python <3

call plug#end()                 
let mapleader = "\<Space>"                         " Set leader to space, this should change my life
nnoremap <Leader>p :CtrlP<CR>                      " This should allow me to open files with space and o
nnoremap <Leader><Tab>  <C-w><C-w><CR>
map <Leader>f :NERDTreeToggle<CR>                  " Toggles NERDTreeToggle
nnoremap <Leader>s :set hlsearch!<CR>              " Turns off search highlighting
colorscheme gruvbox                                " This is the colorscheme
if has("gui_running")
    set guifont=Fira\ Mono\ for\ Powerline         " Make sure to escape the spaces in the name properly
endif
set relativenumber                                 " Set numbers relative to the line that you're on
let g:rainbow_active = 1                           " Sets fancy colors for parenthesis and stuff
set number                                         " Makes the line that the cursor is currently on show absolute value
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let python_highlight_all = 1
let g:deoplete#enable_at_startup = 1
let deoplete#sources#jedi#show_docstring = 1
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
syntax enable
set background=dark                                " Uses the dark gruvbox theme instead of the light alternative
set expandtab                                      " insert spaces instead of tab characters"
set backspace=2                                    " make backspace work like most other apps
set textwidth=79
set fileformat=unix
set shiftwidth=4
set softtabstop=4
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

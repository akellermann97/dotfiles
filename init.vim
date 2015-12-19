call plug#begin('~/.nvim/plugged')

Plug 'Raimondi/delimitMate'
Plug 'tomasr/molokai'
Plug 'scrooloose/syntastic'
Plug 'Shougo/neocomplete.vim'
Plug 'ervandew/supertab'
Plug 'hdima/python-syntax'
Plug 'scrooloose/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'bling/vim-airline'


call plug#end()
" set guifont=Fira\ Mono\ for\ Powerline "make sure to escape the spaces in the name properly
map <F2> :NERDTreeToggle<CR>
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let python_highlight_all = 1
syntax enable
set background=dark
colorscheme gruvbox
set backspace=2 " make backspace work like most other apps
set tabstop=4 
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set softtabstop=4  
set laststatus=2 " Apparently this if for vim-airline
set expandtab 
set number              " This shows number lines
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
nnoremap <leader><space> :nohlsearch<CR> " turn off search highlight
set noswapfile          " Swap files always gave me too much trouble, better off turning them off
set nobackup
set nowritebackup

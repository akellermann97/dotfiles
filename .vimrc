call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'davidhalter/jedi-vim'
Plug 'nvie/vim-flake8'
Plug 'Raimondi/delimitMate'
Plug 'tomasr/molokai'
Plug 'scrooloose/syntastic'
Plug 'Shougo/neocomplete.vim'
Plug 'ervandew/supertab'
Plug 'hdima/python-syntax'
Plug 'scrooloose/nerdtree'
Plug 'morhetz/gruvbox'


call plug#end()


map <F2> :NERDTreeToggle<CR>
let python_highlight_all = 1
syntax enable
set background=dark
colorscheme gruvbox
set backspace=2 " make backspace work like most other apps
set tabstop=4 
set softtabstop=4  
set expandtab 
set number
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

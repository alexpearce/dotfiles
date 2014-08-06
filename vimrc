""""""""""""""""""""""""""""""""""""""""
" General configuration
""""""""""""""""""""""""""""""""""""""""

" Don't need vi compatibility
set nocompatible

" UTF-8 encoding
set encoding=utf-8

" Load all plugins under $HOME/.vim/bundle
execute pathogen#infect()

" Enable filetype detection
filetype plugin indent on

" Disable swp files
set noswapfile

" Enable the mouse in the terminal
set mouse=a
set ttymouse=xterm2

""""""""""""""""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""""""""""""""""

" Syntax highlighting
syntax enable

" Show the executing command
set showcmd

" Theme
set background=dark
colorscheme base16-ocean

" Show relative line number as absolute line number at the cursor position,
" but relative line number above and below the cursor
set number
set relativenumber

" Have some context around the current line always on screen
set scrolloff=3
set sidescrolloff=5

" Try to display very long lines, rather than showing @
set display+=lastline

" Wrap lines in the buffer over 80 characters
" set textwidth=80
" Coloured column at 80 characters, good for wide terminals
if exists('+colorcolumn')
  set colorcolumn=80
endif

" show trailing whitespace as -, tabs as >-
set listchars=tab:>-,trail:-
set list

" Smart case searching
set hlsearch
set incsearch
set ignorecase
set smartcase

""""""""""""""""""""""""""""""""""""""""
" Coding style
""""""""""""""""""""""""""""""""""""""""

" Tabs as two spaces
set tabstop=2
set shiftwidth=2
set expandtab

""""""""""""""""""""""""""""""""""""""""
" Movement
""""""""""""""""""""""""""""""""""""""""

" Make delete key work as expected
set backspace=indent,eol,start

""""""""""""""""""""""""""""""""""""""""
" OS X compatibility
""""""""""""""""""""""""""""""""""""""""

" Share OS X clipboard
set clipboard=unnamed

""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""

" change the leader key to ,
let mapleader=","

" clear search highlighting with ,<space>
nnoremap <leader><space> :noh<cr>

" quick make
map <leader>mm :make<CR>
map <leader>mc :make clean<CR>

" simple pasting from the system clipboard
" http://tilvim.com/2014/03/18/a-better-paste.html
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" Scroll up and down visible lines, not buffer lines
:noremap j gj
:noremap k gk

" Don't autocomplete filenames that match these patterns
" Version control
set wildignore=.svn,.git
" Compiled formats
set wildignore+=*.o,*.pyc
" Images
set wildignore+=*.jpg,*.png,*.pdf
" Auxilary LaTeX files
set wildignore+=*.aux,*.bbl,*.blg,*.out,*.toc
" Web development
set wildignore+=vendor,_site,tmp,node_modules,bower_components

""""""""""""""""""""""""""""""""""""""""
" Filetype specific
""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  " Makefiles require actual tabs
  au FileType make set noexpandtab

  " Python style uses 4 spaces as tabs
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4

  " Spellchecking in LaTeX and Markdown
  au FileType tex,markdown set spelllang=en_gb spell

  " I often type `#` to start a comment, as alt-3, then hit space
  " alt-space is a UTF non-breaking space character, which can give encoding errors
  highlight UTFSpaceComment ctermfg=White ctermbg=1
  au BufNewFile,BufRead * :syn match UTFSpaceComment '.\%uA0'
endif

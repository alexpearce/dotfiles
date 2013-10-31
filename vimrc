" Pathogen plugin manager
execute pathogen#infect()

" Automatic indentation
filetype plugin indent on

" 14pt Monaco
set guifont=Consolas:h15

" Automatically cd in to the directory the buffer lives in
set autochdir

" Don't need vi compatibility
set nocompatible
" Syntax highlighting
syntax enable
" UTF-8 encoding
set encoding=utf-8
" Display useful info in the command bar
set showcmd

" Theme
set t_Co=256
colorscheme pyte
" colorscheme mayansmoke

" Line numbers
set number
" Tabs as two spaces
set tabstop=2
set shiftwidth=2
set expandtab
" Make delete key work as expected
set backspace=indent,eol,start

" Have some context around the current line always on screen
set scrolloff=3

" Smart case searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Wrap lines in the buffer over 80 characters
" set textwidth=80
" Coloured column at 80 characters, good for wide terminals
set colorcolumn=80

" show trailing whitespace as -, tabs as >-
set listchars=tab:>-,trail:-
set list

if has("autocmd")
  " Makefiles require actual tabs
  au FileType make set noexpandtab

  " Python style uses 4 spaces as tabs
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4

  " Disable hard wrapping in Markdown and LaTeX
  au FileType markdown set textwidth=0
  au FileType tex set textwidth=0
endif

" change the leader key to ,
let mapleader=","

" clear search highlighting with ,<space>
nnoremap <leader><space> :noh<cr>

" quick comment toggling
map <leader>c gc

" Disable F1 help
:nmap <F1> :echo<CR>
:imap <F1> <C-o>:echo<CR>

" Don't autocomplete filenames that match these patterns
set wildignore=.svn,.git,*.o,*.jpg,*.png,*.pdf,*.aux,*.bbl,*.blg,*.out,*.toc

" No code folding in LaTeX or Markdown
let g:Tex_AutoFolding = 0
let g:vim_markdown_folding_disabled=1

" Disable LaTeX syntax checking (lacheck is very opinated about style)
let g:syntastic_ignore_files=["tex"]

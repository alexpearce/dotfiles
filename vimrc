" Don't need vi compatibility
set nocompatible

" Pathogen plugin manager
execute pathogen#infect()

" Automatic indentation
filetype plugin indent on

" Syntax highlighting
syntax enable
" UTF-8 encoding
set encoding=utf-8
" Display useful info in the command bar
set showcmd

" Theme
set background=dark
colorscheme base16-ocean

" Line numbers
set number
" Tabs as two spaces
set tabstop=2
set shiftwidth=2
set expandtab
" Make delete key work as expected
set backspace=indent,eol,start
" No folding
set nofoldenable

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
if exists('+colorcolumn')
  set colorcolumn=80
endif

" show trailing whitespace as -, tabs as >-
set listchars=tab:>-,trail:-
set list

" Disable swp files
set noswapfile

" Enable the mouse in the terminal
set mouse=a
set ttymouse=xterm2

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

" change the leader key to ,
let mapleader=","

" clear search highlighting with ,<space>
nnoremap <leader><space> :noh<cr>

" quick comment toggling
map <leader>c gc

" quick make
map <leader>mm :make<CR>
map <leader>mc :make clean<CR>

" quicker command-t
" https://wincent.com/forums/command-t/topics/471
map <leader>l :CommandT<CR>

" simple pasting from the system clipboard
" http://tilvim.com/2014/03/18/a-better-paste.html
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" Disable F1 help
:nmap <F1> :echo<CR>
:imap <F1> <C-o>:echo<CR>

" Scroll up and down visible lines, not buffer lines
:noremap j gj
:noremap k gk

" Don't autocomplete filenames that match these patterns
set wildignore=.svn,.git
set wildignore+=*.o,*.pyc
set wildignore+=*.jpg,*.png,*.pdf
set wildignore+=*.aux,*.bbl,*.blg,*.out,*.toc
set wildignore+=vendor,_site,tmp,node_modules

" No code folding in LaTeX or Markdown
let g:Tex_AutoFolding = 0
let g:vim_markdown_folding_disabled=1

" Disable LaTeX syntax checking (lacheck is very opinated about style)
let g:syntastic_ignore_files=["tex"]
let g:syntastic_cpp_checkers=["gcc"]
let g:syntastic_cpp_compiler_options="`root-config --cflags` `root-config --glibs`"
let g:syntastic_cpp_check_header=1

" Get command-t and tmux to play nice
let g:CommandTCancelMap = ['<ESC>', '<C-c>']
let g:CommandTSelectNextMap = ['<C-j>', '<ESC>OB']
let g:CommandTSelectPrevMap = ['<C-k>', '<ESC>OA']

""""""""""""""""""""""""""""""""""""""""
" General configuration
""""""""""""""""""""""""""""""""""""""""

" Vim is not compatible with fish
set shell=/bin/sh

" UTF-8 encoding
set encoding=utf-8

" Disable swp files
set noswapfile

" Enable the mouse in the terminal
set mouse=a

""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""

" Plugin configuration
" vim-plug does `filetype plugin indent on` for us
call plug#begin('~/.vim/bundle')

Plug 'airblade/vim-gitgutter'
" Use with gruvbox iTerm2 colourscheme from
" https://github.com/flipxfx/gruvbox-terminal
Plug 'alexpearce/gruvbox'
Plug 'christoomey/vim-tmux-navigator'
Plug 'davidhalter/jedi-vim'
Plug 'ehamberg/vim-cute-python'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'ibab/vim-snakemake'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'lervag/vimtex'
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'

call plug#end()

" Search from the git repo root, if we're in a repo, else the cwd
function FuzzyFind()
  " Contains a null-byte that is stripped.
  let gitparent=system('git rev-parse --show-toplevel')[:-2]
  if empty(matchstr(gitparent, '^fatal:.*'))
    silent execute ':FZF -m ' . gitparent
  else
    silent execute ':FZF -m .'
  endif
endfunction

nnoremap <c-p> :call FuzzyFind()<cr>

" Use ag to perform the search, so that .gitignore files and the like are
" respected
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'

let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsListSnippets="<c-s-e>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

""""""""""""""""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""""""""""""""""

" Syntax highlighting
syntax enable

" Show the executing command
set showcmd
set noshowmode

" Theme
set termguicolors
set background=dark
let g:gruvbox_italic=1
colorscheme gruvbox


" Show relative line number as absolute line number at the cursor position,
" but relative line number above and below the cursor
set number
set relativenumber

" Have some context around the current line always on screen
set scrolloff=3
set sidescrolloff=5

" Try to display very long lines, rather than showing @
set display+=lastline

" show trailing whitespace as -, tabs as >-
set listchars=tab:>-,trail:-
set list

" Smart case searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Allow a greater number of tabs to be opened (default: 10)
set tabpagemax=20

if has("nvim")
  set laststatus=1
endif

" airline configuration
set laststatus=2
let g:airline_powerline_fonts = 1
" Show the tabline
let g:airline#extensions#tabline#enabled = 0
" Enable fugitive integration
let g:airline#extensions#branch#enabled = 1
" Enable syntastic integration
let g:airline#extensions#syntastic#enabled = 1
" Override normal, insert, and visual {, line, block}
let g:airline_mode_map = {
  \ 'n'  : '∙',
  \ 'i'  : '|',
  \ 'v'  : '→',
  \ 'V'  : '↔',
  \ '' : '↕',
  \ }

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
set clipboard+=unnamedplus

""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""

" change the leader key to space
let mapleader="\<Space>"

" Stop command window from popping u
map q: :q

" clear search highlighting with <space>,
nnoremap <leader>, :noh<cr>

" quick make
map <leader>m :make<CR>

" simple pasting from the system clipboard
" http://tilvim.com/2014/03/18/a-better-paste.html
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" Scroll up and down visible lines, not buffer lines
noremap j gj
noremap k gk

" Navigate tabs with shift-{h,l}
noremap <S-l> gt
noremap <S-h> gT

" Create splits
nnoremap <Leader>- :split<CR>
nnoremap <Leader>\| :vsplit<CR>

" Quickly save, quit, or save-and-quit
map <leader>w :w<CR>
map <leader>x :x<CR>
map <leader>q :q<CR>

" Search with ag.vim
nnoremap <leader>a :Ag<Space>

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
" Script outputs
set wildignore+=output

" Quickly enable and disable hard wrapping
" I often find this useful for editing LaTeX, when I usually want the lines to
" have fewer than 80 characters, but ocassionally want longer lines
function ToggleWrapping()
  if &l:formatoptions =~ "t"
    set formatoptions-=t
  else
    set formatoptions+=t
  endif
endfunction
nnoremap <leader>t :call ToggleWrapping()<cr>

""""""""""""""""""""""""""""""""""""""""
" Filetype specific
""""""""""""""""""""""""""""""""""""""""
" Always use the 'tex' filetype for .tex files, rather than the dated
" 'plaintex' filetype
let g:tex_flavor = "latex"

if has("autocmd")
  " Makefiles require actual tabs
  au FileType make set noexpandtab

  " Don't create backup files when editing crontabs
  au filetype crontab setlocal nobackup nowritebackup

  " Python style uses 4 spaces as tabs
  " Coloured column at 80 characters, good for wide terminals
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 colorcolumn=80

  " Spellchecking in LaTeX, Markdown, and email
  au FileType tex,markdown,mail set spelllang=en_gb spell

  " Wrap Python, LaTeX, and Markdown automatically at 80 characters, allowing
  " sentences to start on new lines
  au FileType python,tex,markdown set formatoptions+=atw textwidth=79

  " relativenumber can be very slow when combined with a language whose syntax
  " highlighting regexs are complex
  " https://github.com/neovim/neovim/issues/2401
  " https://groups.google.com/forum/#!topic/vim_use/ebRiypE2Xuw
  au FileType tex set norelativenumber

  " I often type `#` to start a comment, as alt-3, then hit space
  " alt-space is a UTF non-breaking space character, which can give encoding errors
  highlight UTFSpaceComment ctermfg=White ctermbg=1
  au BufNewFile,BufRead * :syn match UTFSpaceComment '.\%uA0'
endif

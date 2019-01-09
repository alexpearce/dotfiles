""""""""""""""""""""""""""""""""""""""""
" General configuration
""""""""""""""""""""""""""""""""""""""""

" Disable swp files
set noswapfile

" Enable persistent undo
set undofile

" Enable the mouse in the terminal
set mouse=a

" Share the system clipboard
set clipboard+=unnamedplus

" As recommended by `:help provider`, define a venv just for neovim that has
" the neovim module and some Python linters
let g:python_host_prog = $HOME . "/.nvim-venv2/bin/python2"
let g:python3_host_prog = $HOME . "/.nvim-venv/bin/python3"

""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""

" Plugin configuration
call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'ervandew/supertab'
Plug 'ivan-krukov/vim-snakemake'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'nathangrigg/vim-beancount'
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-scripts/UniCycle'
Plug 'w0rp/ale'

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

" Use rg to perform the search, so that .gitignore files and the like are
" respected
let $FZF_DEFAULT_COMMAND = 'rg --files'

" Airline configuration
let g:airline_powerline_fonts = 1
" Don't show empty warning or error sections
let g:airline_skip_empty_sections = 1
" " Override normal, insert, and visual {, line, block}
let g:airline_mode_map = {
  \ 'n'  : '∙',
  \ 'i'  : '|',
  \ 'v'  : '→',
  \ 'V'  : '↔',
  \ '' : '↕',
  \ }

" Don't show the foldcolumn
let g:pandoc#folding#fdc = 0
" Soft wraps, but not in regions where wrapping is undesirable (like headers
" and code blocks)
let g:pandoc#formatting#mode = 'hA'

" Append our Neovim virtualenv to the list of venvs ale searches for
" The search is performed from the buffer directory up, until a name match is
" found; our Neovim venv lives in ~/.nvim-venv
let g:ale_virtualenv_dir_names = ['.env', '.venv', 'env', 'virtualenv', 'venv', '.nvim-venv']
" Explicitly list linters we care about
let g:ale_linters = {'python': ['flake8', 'pylint']}
" Only show warnings and errors from pylint
let g:ale_python_pylint_options = '--disable C,R'
let g:ale_sign_warning = '→'
let g:ale_sign_error = '→'

""""""""""""""""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""""""""""""""""

" Show the executing command
set showcmd
" Don't show the current editing mode
set noshowmode
"
" Theme
set termguicolors
set background=dark
let g:nord_italic=1
let g:nord_italic_comments = 1
let g:nord_underline = 1
let g:airline_theme = 'nord'
color nord
hi Conceal guifg=#81A1C1 guibg=NONE ctermbg=NONE

" Have some context around the current line always on screen
set scrolloff=3
set sidescrolloff=5

" Try to display very long lines, rather than showing @
set display+=lastline

" show trailing whitespace as -, tabs as >-
set listchars=tab:>-,trail:-
set list

" Smart case searching
set ignorecase
set smartcase

" Live substitution
set inccommand=split

if has("nvim")
  set laststatus=1
endif

""""""""""""""""""""""""""""""""""""""""
" Coding style
""""""""""""""""""""""""""""""""""""""""

" Tabs as two spaces
set tabstop=2
set shiftwidth=2
set expandtab

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
map <Leader>p :set paste<CR>o<esc>"+]p:set nopaste<cr>

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

function ToggleRelativeLineNumbers()
  set invnumber
  set invrelativenumber
endfunction
nnoremap <leader>l :call ToggleRelativeLineNumbers()<cr>

function ToggleGoyoLimelight()
  Goyo
  Limelight
endfunction
nnoremap <leader>g :call ToggleGoyoLimelight()<cr>

""""""""""""""""""""""""""""""""""""""""
" Wiki
""""""""""""""""""""""""""""""""""""""""

" Open the index file of the wiki
function WikiIndex()
  let path = fnameescape(expand(g:wiki_root)) . '/index.' . g:wiki_extension
  execute 'e ' . path
endfunction

function WikiDiary()
  let path = fnameescape(expand(g:wiki_root)) . '/diary/diary.' . g:wiki_extension
  execute 'e ' . path
endfunction

function WikiDiaryToday()
  let date = strftime('%Y-%m-%d')
  let fname = date . '.' . g:wiki_extension
  let path = fnameescape(expand(g:wiki_root)) . '/diary/' . fname
  execute 'e ' . path
  " Insert the date as a header if the file doesn't exist
  if !filereadable(path)
    call append(0, '# '. date)
    call append(1, '')
  endif
endfunction

let g:wiki_root = '~/Dropbox/vimwiki'
let g:wiki_extension = 'markdown'

nmap <Leader>vw :call WikiIndex() <cr>
nmap <Leader>vd :call WikiDiary() <cr>
nmap <Leader>vn :call WikiDiaryToday() <cr>
nmap <Leader>vh :call VimwikiAll2HTML() <cr>

""""""""""""""""""""""""""""""""""""""""
" Filetype specific
""""""""""""""""""""""""""""""""""""""""

" Always assume .tex files are LaTeX
let g:tex_flavor = "latex"

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

au BufNewFile,BufRead ~/.mutt/tmp/neomutt-* setlocal filetype=mail

" Makefiles require actual tabs
au FileType make setlocal noexpandtab

" Don't create backup files when editing crontabs
au filetype crontab setlocal nobackup nowritebackup

" Python style uses 4 spaces as tabs
au FileType python setlocal tabstop=4 shiftwidth=4
" Enable deoplete
au FileType python call deoplete#enable()

au BufNewFile,BufRead *.markdown setlocal syntax=markdown

" Spellchecking in LaTeX, Markdown, and email
au FileType tex,plaintex,markdown,pandoc,mail setlocal spelllang=en_gb spell formatoptions=tcroqlj

" Wrap Python automatically at 80 characters
au FileType python setlocal textwidth=79 formatoptions=tcroqlj

" Smart quotes, dashes, and ellipses in markdown and emails
au FileType mail,markdown UniCycleOn

" relativenumber can be very slow when combined with a language whose syntax
" highlighting regexs are complex
" https://github.com/neovim/neovim/issues/2401
" https://groups.google.com/forum/#!topic/vim_use/ebRiypE2Xuw
au FileType tex set norelativenumber

" Enable marker folder for Beancount files
au FileType beancount set foldmethod=marker foldlevel=0 foldlevelstart=0

" I often type `#` to start a comment, as alt-3, then hit space
" alt-space is a UTF non-breaking space character, which can give encoding errors
highlight UTFSpaceComment ctermfg=White ctermbg=1
au BufNewFile,BufRead * :syn match UTFSpaceComment '.\%uA0'

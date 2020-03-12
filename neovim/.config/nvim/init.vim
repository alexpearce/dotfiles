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
Plug 'alexpearce/nvim-follow-markdown-links', { 'do': ':UpdateRemotePlugins' }
Plug 'arcticicestudio/nord-vim'
Plug 'bfrg/vim-cpp-modern'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'ervandew/supertab'
" Dependency of vim-OnSyntaxChange
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-OnSyntaxChange'
Plug 'ivan-krukov/vim-snakemake'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'nathangrigg/vim-beancount'
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'valloric/youcompleteme', { 'do': './install.py --clang-completer' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-scripts/UniCycle'
Plug 'wincent/loupe'

call plug#end()

" Search from the git repo root, if we're in a repo, else the cwd
function FuzzyFind(show_hidden)
  " Contains a null-byte that is stripped.
  let gitparent=system('git rev-parse --show-toplevel')[:-2]
  if a:show_hidden
    let $FZF_DEFAULT_COMMAND = g:fzf_default_command . ' --hidden'
  else
    let $FZF_DEFAULT_COMMAND = g:fzf_default_command
  endif
  if empty(matchstr(gitparent, '^fatal:.*'))
    silent execute ':FZF -m ' . gitparent
  else
    silent execute ':FZF -m .'
  endif
endfunction

nnoremap <c-p> :call FuzzyFind(0)<cr>
nnoremap <c-i> :call FuzzyFind(1)<cr>

" Use rg to perform the search, so that .gitignore files and the like are
" respected
let g:fzf_default_command = 'rg --files'

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

let g:pear_tree_smart_openers=1
let g:pear_tree_smart_closers=1
let g:pear_tree_smart_backspace=1

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_insertion = 1

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
let g:nord_italic = 1
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
nmap <leader>, <Plug>(LoupeClearHighlight)

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

nnoremap <leader>g :YcmCompleter GoTo<cr>
nnoremap <leader>f :YcmCompleter FixIt<cr>
nnoremap <leader>t :YcmCompleter GetType<cr>

""""""""""""""""""""""""""""""""""""""""
" Wiki
""""""""""""""""""""""""""""""""""""""""

" Open the index file of the wiki
function WikiIndex()
  let path = fnameescape(expand(g:wiki_root)) . '/README.' . g:wiki_extension
  execute 'e ' . path
endfunction

function WikiDiary()
  let path = fnameescape(expand(g:wiki_root)) . '/HEP/Log/README.' . g:wiki_extension
  execute 'e ' . path
endfunction

function WikiDiaryToday()
  let date = strftime('%Y-%m-%d')
  let fname = date . '.' . g:wiki_extension
  let path = fnameescape(expand(g:wiki_root)) . '/HEP/Log/' . fname
  execute 'e ' . path
  " Insert the date as a header if the file doesn't exist
  if !filereadable(path)
    call append(0, '# '. date)
    call append(1, '')
  endif
endfunction

function WikiSearch()
  exe "FZF " . g:wiki_root
endfunction

" function WikiSearchText()
"   " call fzf#run(fzf#wrap('FZF', {'dir': expand(g:wiki_root)}, 0))
"   call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>)." ".g:wiki_root, 1, 0)
" endfunction

let g:wiki_root = '~/Dropbox/kb'
let g:wiki_extension = 'md'

nmap <Leader>vw :call WikiIndex() <cr>
nmap <Leader>vd :call WikiDiary() <cr>
nmap <Leader>vn :call WikiDiaryToday() <cr>
nmap <Leader>vp :call WikiSearch() <cr>
nmap <Leader>vh :call VimwikiAll2HTML() <cr>

let g:follow_markdown_links#extensions = ['.md', '.markdown']
command! FollowMarkdownLink call FollowMarkdownLink()
command! PreviousMarkdownBuffer call PreviousMarkdownBuffer()
autocmd FileType markdown nnoremap <script> <CR> :FollowMarkdownLink<CR>
autocmd FileType markdown nnoremap <script> <BS> :PreviousMarkdownBuffer<CR>

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

au BufNewFile,BufRead *.md setlocal filetype=markdown.pandoc
au BufNewFile,BufRead *.markdown setlocal filetype=markdown.pandoc

" Spellchecking in LaTeX, Markdown, reStructured text
au FileType tex,plaintex,markdown,rst setlocal spelllang=en_gb spell formatoptions=tcroqlj

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

augroup mail
  au!

  au FileType mail setlocal spell spelllang=en_gb

  " Common standard used in plaintext emails
  au FileType mail setlocal textwidth=72

  " w: Lines ending with spaces continue on the next line, used in combination
  "    with Mutt's text_flowed option
  " a: Format automatically
  " t: Wrap using textwidth
  " c: Wrap comments using textwidth
  " q: Format with gq macro
  au FileType mail setlocal formatoptions=watcq

  " Define comment leaders as in a Markdown document, that is:
  " * Treat *, -, +, and > as comment leaders
  " * Characters *, -, + begin comments when followed by a space, and wrapped
  "   lines immediately after these should be indented
  " * Comments starting with > can be nested
  au FileType mail setlocal comments=fb:*,fb:-,fb:+,n:>

  " Install an autogroup that triggers when inside a `mail.*` syntax group
  au FileType mail call OnSyntaxChange#Install('NoWrapElements', '^mail', 1, 'a')

  " Use the trigger to disable/enable text wrapping when leaving/enter the
  " mail body (i.e. we only want wrapping in the mail body).
  au FileType mail autocmd User SyntaxNoWrapElementsEnterA setlocal formatoptions-=watc
  au FileType mail autocmd User SyntaxNoWrapElementsLeaveA setlocal formatoptions+=watc
augroup end

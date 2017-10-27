# Alias commands to include common flags
alias ipython "ipython --no-banner"
alias root "root -l"
alias nvim "nvim -p";
alias vim "vim -p"

alias rm "rm -i"
alias cp "cp -i"
alias mv "mv -i"
alias mkdir "mkdir -p"
alias du "du -hs"
if which exa > /dev/null 2>&1
  alias ls "exa"
  alias la "exa -aghl --git"
end
alias pcat "pygmentize -f terminal16m -O style=monokai"

# Abbreviate commonly used functions
# An abbreviation will expand after <space> or <Enter> is hit
abbr o open
abbr g git
abbr gx gitx
abbr gho "github_open ."
abbr ghoi "github_open issues"
abbr ghopr "github_open pulls"
abbr p python
abbr ip ipython
# Set up virtualfish (virtualenvwrapper for fish, try `vf` command)
abbr pyvf "eval (python -m virtualfish auto_activation)"
abbr be "bundle exec"
abbr r root
abbr tb tbrowser
abbr v vim
abbr nv nvim
abbr ospdf "open -a Skim *.pdf"
abbr m make
abbr se setup-env
abbr dbg 'set CMTCONFIG $CMTDEB'

abbr gia "git add"
abbr gb "git branch"
abbr gco "git checkout"
abbr gc "git commit"
abbr gcm "git commit -m"
abbr gwd "git diff"
abbr gws "git status -s -b"
abbr gs "git stash"
abbr gsp "git stash pop"
abbr gsx "git stash drop"
abbr gssp "git stash show -p"
abbr grb "git rebase"
abbr gr "git reset"

abbr cern "ssh lxplus.cern.ch"
# I don't know why I need the -K flag, I get a password prompt otherwise
# I thought the GSSAPIDelegateCredentials config flag did the same thing, which
# I have enabled for CERN hosts, but it doesn't work without -K
abbr apv "ssh -K apv"

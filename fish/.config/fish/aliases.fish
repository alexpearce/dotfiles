# Alias commands to include common flags
alias ipython "ipython --no-banner"
alias root "root -l"
# Only use Neovim if the command is known
# There must be a nicer way of doing this...
which nvim > /dev/null ^ /dev/null; and alias vim "nvim -p"

alias rm "rm -i"
alias cp "cp -i"
alias mv "mv -i"
alias mkdir "mkdir -p"

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
abbr r root
abbr tb tbrowser
abbr v vim
abbr ospdf "open -a Skim *.pdf"

abbr gia "git add"
abbr gb "git branch"
abbr gco "git checkout"
abbr gc "git commit"
abbr gcm "git commit -m"
abbr gwd "git diff"
abbr gws "git status"
abbr gs "git stash"
abbr gsp "git stash pop"
abbr gsx "git stash drop"

abbr cern "ssh lxplus.cern.ch"

abbr docker-init "eval (docker-machine env default --shell=fish)"

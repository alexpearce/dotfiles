# Function aliases
alias o open
alias g git
alias gx gitx
alias p python
alias ip "ipython --no-banner"
alias r "root -l"
alias vim "vim -p"
alias v vim

alias rm "rm -i"
alias mv "mv -i"

alias gia "git add"
alias gb "git branch"
alias gco "git checkout"
alias gc "git commit"
alias gcm "git commit -m"
alias gwd "git diff"
alias gws "git status"
alias gs "git stash"
alias gsp "git stash pop"
alias gsx "git stash drop"

alias kerb "kinit -l 24h apearce@CERN.CH; and aklog"
alias cern "ssh lxplus.cern.ch"

set -x AFS /afs/cern.ch/user/a/apearce
set -x WORK /afs/cern.ch/work/a/apearce

function ctrlp -d "Launch CtrlP inside Vim"
  vim -c CtrlP
end

function fish_user_key_bindings -d "Set custom key bindings"
  bind \cp ctrlp
end

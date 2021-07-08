# Alias commands to include common flags
alias ipython "ipython --no-banner"
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

# Abbreviate commonly used functions
# An abbreviation will expand after <space> or <Enter> is hit
abbr o open
abbr b bat
abbr g git
abbr p python3
abbr ip ipython
abbr n nvim
abbr m make

abbr ga "git add"
abbr gap "git add -p"
abbr gc "git commit"
abbr gcan "git commit --amend --no-edit"
abbr gcm "git commit -m"
abbr gcl "git clone"
abbr gd "git diff"
abbr gds "git diff --staged"
abbr gp "git push"
abbr gpf "git push -f"
abbr gr "git restore"
abbr grb "git rebase"
abbr grba "git rebase --abort"
abbr grbc "git rebase --continue"
abbr grbi "git rebase -i"
abbr gs "git status -s -b"
abbr gst "git stash"
abbr gstp "git stash pop"
abbr gsts "git stash show -p"
abbr gstx "git stash drop"
abbr gsw "git switch"
abbr gswc "git switch -c"

# Alias commands to include common flags
alias ipython "ipython --no-banner"
alias root "root -l"
# Only use Neovim if the command is known
# There must be a nicer way of doing this...
which nvim > /dev/null ^ /dev/null; and alias vim "nvim -p"; or alias vim "vim -p"

alias rm "rm -i"
alias cp "cp -i"
alias mv "mv -i"
alias mkdir "mkdir -p"

# EOS on lxplus
alias eos="/afs/cern.ch/project/eos/installation/0.3.15/bin/eos.select"
alias eosumount="/afs/cern.ch/project/eos/installation/0.3.15/bin/eos.select -b fuse umount"
alias eosmount="/afs/cern.ch/project/eos/installation/0.3.15/bin/eos.select -b fuse mount"
alias eosforceumount="killall eosfsd 2>/dev/null; killall -9 eosfsd 2>/dev/null; fusermount -u "

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
abbr be "bundle exec"
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
# I don't know why I need the -K flag, I get a password prompt otherwise
# I thought the GSSAPIDelegateCredentials config flag did the same thing, which
# I have enabled for CERN hosts, but it doesn't work without -K
abbr apv "ssh -K apv"

abbr docker-init "eval (docker-machine env default --shell=fish)"

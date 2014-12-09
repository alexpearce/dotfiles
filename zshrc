# OS X only
if [[ "`uname`" == "Darwin" ]]; then
  # PyROOT
  export ROOTSYS=$(brew --prefix root)
  export PYTHONPATH=$ROOTSYS/lib/root:$PYTHONPATH
else
  export PATH=$HOME/usr/bin:$PATH
fi

# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#
# Aliases
#

# Customize to your needs...
# CERN stuff
alias kerberos="kinit apearce@CERN.CH && aklog"
alias ktmux="pagsh.krb -c 'kinit && tmux'"
alias cern="ssh lxplus.cern.ch"

# Executable shortcuts
alias root="root -l"
alias tb="tbrowser"
alias irb="pry"
alias be="bundle exec"
alias p="python"
alias ip="ipython --no-banner"

# SVN *shudder*
alias sst="svn status"
alias sdiff="svn diff | less"

# Shell utilities
alias q="exit"
alias k="clear"
alias cdk="cd && clear"
alias todo="ag TODO"
# I do this all the time
alias :q="exit"

# Handy snippets
# image dimensions
alias image-d="sips -g pixelWidth -g pixelHeight"
# http://xkcd.com/1168/
alias tarup="tar czvf"

# Open vim, one tab per file
alias v="vim -p"

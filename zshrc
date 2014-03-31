# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Only for OS X
# http://stackoverflow.com/questions/394230/detect-the-os-from-a-bash-script
if [[ "`uname`" == "Darwin" ]]; then
  # Python/virtualenv
  export WORKON=$HOME/.virtualenvs
  export PIP_VIRTUALENV_BASE=$WORKON
  export PIP_RESPECT_VIRTUAL_ENV=true
  export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
  export VIRTUALENVWRAPPER_VIRTUALENV_ARGS="--no-site-packages"
  if [[ -r /usr/local/bin/virtualenvwrapper.sh ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
  fi

  # PyROOT
  export ROOTSYS=$(brew --prefix root)
  export PYTHONPATH=$ROOTSYS/lib/root:$PYTHONPATH

  # Go
  # http://golang.org/doc/code.html
  export GOPATH=$HOME/Code/Go

  path=(
    # Homebrew
    $(brew --prefix)/bin
    # XQuartz
    /opt/X11/bin
    # TeXLive
    /usr/texbin
    # Go
    $GOPATH/bin
    $(brew --prefix)/Cellar/go/1.2.1/libexec/bin
    # System defaults
    /usr/{s,}bin
    /bin
    /sbin
  )

  # rbenv
  if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
else
  export PATH=$HOME/usr/bin:$PATH
fi

# Source environment vars
source $HOME/.zsh_vars
# Source aliases
source $HOME/.zsh_aliases

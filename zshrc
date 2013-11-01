# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# nVidia CUDA
cuda=/Developer/NVIDIA/CUDA-5.0

path=(
  # Homebrew
  $(brew --prefix)/bin
  # ROOT
  /usr/local/root/bin
  # XQuartz
  /opt/X11/bin
  # TeXLive
  /usr/texbin
  # nVidia CUDA
  $cuda/bin
  # System defaults
  /usr/{s,}bin
  /bin
  /sbin
)

# PyROOT
export PYTHONPATH=/usr/local/root/lib:$PYTHONPATH

# Source environment vars
source $HOME/.zsh_vars
# Source aliases
source $HOME/.zsh_aliases

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

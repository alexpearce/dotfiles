# Source Conda install if present
# Install Mambaforge from:
#   https://github.com/conda-forge/miniforge#mambaforge
if test -x "$HOME/.local/conda/bin/conda"
  eval "$HOME/.local/conda/bin/conda" "shell.fish" "hook" $argv | source
end

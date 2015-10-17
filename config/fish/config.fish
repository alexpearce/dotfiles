# Start tmux automatically, attaching to an existing session if possible
if set -q $TMUX
  tmux attach ^/dev/null; or tmux
end

# Set paths for ROOT
set -x ROOTSYS (brew --prefix root6)
set -x PYTHONPATH $ROOTSYS/lib/root $PYTHONPATH

# Set up virtualfish (use it like virtualenvwrapper)
eval (python -m virtualfish compat_aliases)

set -l source_dir (dirname (status -f))
source $source_dir/aliases.fish
source $source_dir/folder_commands.fish
source $source_dir/git.fish

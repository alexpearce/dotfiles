# Start tmux automatically, attaching to an existing session if possible
if set -q $TMUX
  tmux attach ^/dev/null; or tmux
end

# Set up virtualfish (use it like virtualenvwrapper)
eval (python -m virtualfish compat_aliases)

set -l source_dir (dirname (status -f))
source $source_dir/aliases.fish
source $source_dir/folder_commands.fish
source $source_dir/git.fish

# This file is sourced twice on fish start-up, once interactively
# and then once non-interactively. This wrapper prevents our PATH
# manipulation being repeated
if status --is-interactive
  set PATH ~/.bin $PATH
end

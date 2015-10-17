# Start tmux automatically, attaching to an existing session if possible
if set -q $TMUX
  tmux attach ^/dev/null; or tmux
end

# Set up virtualfish (virtualenvwrapper for fish, try `vf` command)
eval (python -m virtualfish auto_activation)

set -l source_dir (dirname (status -f))
source $source_dir/aliases.fish
source $source_dir/folder_commands.fish
source $source_dir/git.fish

# This file is sourced twice on fish start-up, once interactively
# and then once non-interactively. This wrapper prevents things
# like PATH manipulation being repeated
if status --is-interactive
  source $source_dir/env.fish
end

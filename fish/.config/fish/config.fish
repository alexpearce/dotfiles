# Start tmux automatically if we're not connecting over SSH,
# attaching to an existing session if possible
if not set -q TMUX; and not is_ssh
  tmux attach ^/dev/null; or tmux
end

# Set up virtualfish (virtualenvwrapper for fish, try `vf` command)
if python -m virtualfish > /dev/null ^&1
  eval (python -m virtualfish auto_activation)
end

set -l source_dir (dirname (status -f))

# This file is sourced twice on fish start-up, once interactively
# and then once non-interactively. This wrapper prevents things
# like PATH manipulation being repeated
if status --is-interactive
  source $source_dir/env.fish
  if is_cern
    source $source_dir/env_cern.fish
  else
    # Set paths for ROOT
    set -x ROOTSYS (brew --prefix root6)
    set -x PYTHONPATH $ROOTSYS/lib/root $PYTHONPATH
  end
end

source $source_dir/aliases.fish
source $source_dir/git.fish

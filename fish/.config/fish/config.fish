function is_ssh -d "Test whether session is under SSH"
  test -n "$SSH_CLIENT" -o -n "$SSH_TTY"
end
function is_cern -d "Test whether host is a CERN machine"
  # Most CERN machines have a hostname ending in cern.ch
  test (hostname | grep -E cern\.ch)
  # But not the ones in the LHCb online network
  or test (hostname | grep -E "(gw|plus)[0-9]+")
end

# Start tmux automatically if we're not connecting over SSH,
# attaching to an existing session if possible
if begin; set -q $TMUX; not is_ssh; end
  tmux attach ^/dev/null; or tmux
end

# Set up virtualfish (virtualenvwrapper for fish, try `vf` command)
if not is_cern
  eval (python -m virtualfish auto_activation)
end

set -l source_dir (dirname (status -f))
source $source_dir/aliases.fish
source $source_dir/folder_commands.fish
source $source_dir/git.fish

# This file is sourced twice on fish start-up, once interactively
# and then once non-interactively. This wrapper prevents things
# like PATH manipulation being repeated
if status --is-interactive
  source $source_dir/env.fish
  if is_cern
    source $source_dir/env_cern.fish
  end
  # Set paths for ROOT
  set -x ROOTSYS (brew --prefix root6)
  set -x PYTHONPATH $ROOTSYS/lib/root $PYTHONPATH
end

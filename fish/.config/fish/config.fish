# Start tmux automatically if we're not connecting over SSH,
# attaching to an existing session if possible
if not set -q TMUX; and not is_ssh
  tmux attach ^/dev/null; or tmux
end

set -l source_dir (dirname (status -f))

source $source_dir/env.fish
source $source_dir/aliases.fish
source $source_dir/git.fish

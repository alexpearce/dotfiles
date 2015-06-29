# Disable the greeting message
function fish_greeting
end

# Set prompt with pwd and git information
function fish_prompt
  echo
  set_color blue
  printf '%s' (pwd | sed -e "s|$HOME|~|")
  set_color normal

  printf '%s' (__fish_git_prompt)
  set_color normal
  printf '\n> '
end

# Set right prompt with virtualenv information
function fish_right_prompt
  if set -q VIRTUAL_ENV
    set_color 666
    echo -n (basename (echo $VIRTUAL_ENV))
    set_color normal
  end
end

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

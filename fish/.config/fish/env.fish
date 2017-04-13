# Fish stores 'universal' variables in hostname-specific configuration files,
# e.g. ~/.config/fish/fishd.02163e018f66.
# The little block below prompts the user to set these variables if they
# haven't been already.
# But, using a load-balanced cluster of machines, like CERN's lxplus,
# doesn't play well with universal variables, because you're sent to one
# of many possible machines when you SSH in.
# This means we need to run setup-env quite often.
if not set -q fish_user_paths
  echo 'Hello! This is your shell 👋'
  echo 'It looks this the machine ('(hostname)') hasn\'t been setup yet.'
  echo 'You can run the '(set_color green)'setup-env'(set_color normal)' command to do so.'
end

# Even after setup-env, some universal variables are overriden
# by CERN-controlled login scripts on subsequent logins!
# So we must override those ourselves (again), which we do here.
if is_cern
  set -e EDITOR
  set -g -x EDITOR nvim
  set -g -x LD_LIBRARY_PATH ~/usr/lib:$LD_LIBRARY_PATH
end

# Set syntax highlighting colours; var names defined here:
# http://fishshell.com/docs/current/index.html#variables-color
set fish_color_normal normal
set fish_color_command white
set fish_color_quote brgreen
set fish_color_redirection brblue
set fish_color_end white
set fish_color_error -o brred
set fish_color_param brpurple
set fish_color_comment --italics brblack
set fish_color_match cyan
set fish_color_search_match --background=brblack
set fish_color_operator cyan
set fish_color_escape white
set fish_color_autosuggestion brblack

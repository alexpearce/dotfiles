set -g -x EDITOR nvim

if is_cern
  set -g -x fish_user_paths ~/usr/bin $fish_user_paths
  set -g -x LD_LIBRARY_PATH ~/usr/lib:$LD_LIBRARY_PATH
  # Place Grid proxy somewhere host agnostic (it's placed in /tmp by default)
  set -g -x X509_USER_PROXY $HOME/.grid.proxy
end

# Don't let sourcing virtualenvs change our prompt
# We use the env name in the right prompt anyway
set -g -x VIRTUAL_ENV_DISABLE_PROMPT 1

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

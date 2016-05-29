if command --search nvim >/dev/null
  set -x EDITOR nvim
else
  set -x EDITOR vim
end

set PATH ~/.bin $PATH

set -x NVIM_TUI_ENABLE_TRUE_COLOR 1

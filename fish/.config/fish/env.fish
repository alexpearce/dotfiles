command --search nvim >/dev/null; and begin
  set -gx EDITOR nvim
end; or begin
  set -gx EDITOR vim
end

set PATH ~/.bin $PATH

set -gx NVIM_TUI_ENABLE_TRUE_COLOR 1

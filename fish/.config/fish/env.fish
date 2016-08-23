if command --search nvim >/dev/null
  set -x EDITOR nvim
else
  set -x EDITOR vim
end

set PATH ~/.bin $PATH

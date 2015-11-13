function fish_right_prompt -d "Set right prompt with virtualenv information"
  if set -q VIRTUAL_ENV
    set_color 666
    echo -n (basename (echo $VIRTUAL_ENV))
    set_color normal
  end
end


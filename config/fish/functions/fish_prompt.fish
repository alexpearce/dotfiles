function fish_prompt -d "Set prompt with pwd and git information"
  echo
  set_color blue
  printf '%s' (pwd | sed -e "s|$HOME|~|")
  set_color normal

  printf '%s' (__fish_git_prompt)
  set_color normal
  printf '\n> '
end

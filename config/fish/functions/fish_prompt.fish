function fish_prompt -d "Set prompt with pwd and git information"
  echo
  # Show username@hostname if this is an SSH session
  if test -n "$SSH_CLIENT" -o -n "$SSH_TTY"
    set_color red
    printf '%s' (whoami)
    set_color normal
    printf '@'
    set_color purple
    printf '%s' (hostname)
    set_color normal
    printf ' '
  end
  set_color blue
  printf '%s' (pwd | sed -e "s|$HOME|~|")
  set_color normal

  printf '%s' (__fish_git_prompt)
  set_color normal
  printf '\n> '
end

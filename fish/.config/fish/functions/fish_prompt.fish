function fish_prompt -d "Set prompt with pwd and git information"
  echo
  # Show username@hostname if this is an SSH session
  if is_ssh
    set_color red
    printf '%s' (whoami)
    set_color normal
    printf '@'
    set_color purple
    if is_cern
      printf '%s' (hostname | sed -e "s/\.cern\.ch//")
    else
      printf '%s' (hostname)
    end
    set_color normal
    printf ' '
  end
  set_color blue
  # Use pipe delimiters as the path $HOME contains forward slashes
  printf '%s' (pwd | sed -e "s|$HOME|~|")
  set_color normal

  printf '%s' (__fish_git_prompt)
  set_color normal
  printf '\n> '
end

function fish_prompt -d "Set prompt with pwd and git information"
  # Store the status of the last command so that we can query it later
  set -l _prompt_status $status

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

  if test "$_prompt_status" -gt 0
    set_color red
    printf ' · '
    set_color black
    printf '(%s)' "$_prompt_status"
  end
  set_color normal

  printf '\n'
  iterm2_prompt_mark
  printf '> '
end

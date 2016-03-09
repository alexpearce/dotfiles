function is_ssh -d "Test whether session is under SSH"
  test -n "$SSH_CLIENT" -o -n "$SSH_TTY"
end

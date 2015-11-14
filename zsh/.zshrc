# Start fish shell
if [ -z "$NOFISH" ] && [ -f "$HOME/usr/bin/fish" ]; then
  ~/usr/bin/fish
  # Exit from zsh immediately if fish exited successfully
  if [ $? -eq 0 ];
    exit
  fi
  echo 'Fish exited with an error, dropping to zsh shell'
fi
echo 'Setting up zsh shell'

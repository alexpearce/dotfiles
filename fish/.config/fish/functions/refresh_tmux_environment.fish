function refresh_tmux_environment --on-event fish_preexec -d "Ensure the current process is up-to-date with the known tmux environment"
  # Tmux keeps a record of the values of some environment variables from the parent process.
  # These values are updated whenever a tmux session is created or attached to.
  # New windows or panes pick up the updated values, however existing processes will not.
  # This function, which runs before every command run in the shell, ensures that the current process's environment matches that known to tmux

  if set -q TMUX
    # Filter out variables that were not set in parent that started tmux (tmux prepends '-' for unset variables)
    for line in (tmux show-environment | grep '^[^-]')
      # Split by the equals sign to get the variable name and value
      set -l varname (echo $line | sed -r 's/(.*)=.*/\1/')
      set -l varvalue (echo $line | sed -r 's/.*=(.*)/\1/')
      # Set the variable in this session
      set -g -x "$varname" "$varvalue"
    end
  end
end

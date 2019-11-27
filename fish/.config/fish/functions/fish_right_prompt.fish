function fish_right_prompt -d "Set right prompt with virtualenv information"
  if set -q VIRTUAL_ENV
    set_color 666
    echo -n '('(basename (echo $VIRTUAL_ENV))') '
    set_color normal
  end

  # Display the time the command took to execute
  # Relies on cmd_start_time being set, as is done by the
  # start_command_timer function
  set cmd_time_stop (date +%s)
  set cmd_time_delta (math $cmd_time_stop - $cmd_time_start)
  # https://stackoverflow.com/questions/8903239#comment11135511_8903280
  if test $cmd_time_delta -gt 1
    set_color 666
    if test $cmd_time_delta -lt 60
      # Only show seconds
      echo (date -u -r "$cmd_time_delta" +'%-Ss')
    else
      # Show seconds and minutes
      echo (date -u -r "$cmd_time_delta" +'%-Mm %-Ss')
    end
  end
end

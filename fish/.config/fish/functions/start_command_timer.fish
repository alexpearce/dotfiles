function start_command_timer --on-event fish_preexec -d "Record the time a command started"
  set -g cmd_time_start (date +%s)
end


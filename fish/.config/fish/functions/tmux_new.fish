function tmux_new -d "Start a new tmux session with preconfigured windows"
  # Ensure our environment refresher is running
  refresh_tmux_environment; and tmux new \; \
    rename-window mail \; \
    send-keys -t 1 'cd ~/Downloads; and neomutt' Enter \; \
    new-window -n log \; \
    send-keys -t 2 'cd ~/Dropbox/kb; and nvim -c ":call WikiDiaryToday()"' Enter \; \
    new-window
end

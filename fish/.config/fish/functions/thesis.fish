function thesis -d "Set up tmux session for thesis writing"
  cd ~/Documents/LHCb/Thesis
  tmux rename-window Thesis
  # Vertical split
  tmux split-window -v
  # Select the bottom pane
  tmux select-pane -t 1
  # Shrink the bottom pane by 'some amount'
  tmux resize-pane -D 20
  # Open the PDF viewier
  tmux send-keys "open thesis.pdf" C-m
  # Start the watcher to automatically recompile when a .tex file changes
  tmux send-keys "fswatch -0 **.tex | xargs -0 -n1 -I\"{}\" ./latexrun --latex-cmd=lualatex thesis.tex" C-m
  # Select the top pane
  tmux select-pane -t 0
  # Open ctrl-p in vim
  tmux send-keys C-p
end

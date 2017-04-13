function nvimag -d "Open matching files with nvim"
  # Open nvim with the search term highlighted
  nvim (ag -l $argv) +/"$argv[1]"
end

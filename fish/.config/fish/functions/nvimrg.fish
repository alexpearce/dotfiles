function nvimrg -d "Open matching files with nvim"
  # Open nvim with the search term highlighted
  nvim (rg -l $argv) +/"$argv[1]"
end

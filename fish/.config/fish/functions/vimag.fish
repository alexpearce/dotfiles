function vimag -d "Open matching files with vim"
  # Open vim with the search term highlighted
  vim (ag -l $argv) +/"$argv[1]"
end

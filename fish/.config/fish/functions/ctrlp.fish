function ctrlp -d "Launch fzf, inside Vim, from the shell" --argument-names hidden
  if test -n "$hidden"
    nvim -c 'call FuzzyFind(1)'
  else
    nvim -c 'call FuzzyFind(0)'
  end
end

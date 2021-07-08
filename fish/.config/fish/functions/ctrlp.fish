function ctrlp -d "Launch Neovim file finder from the shell" --argument-names hidden
  if test -n "$hidden"
    nvim -c 'lua require(\'telescope.builtin\').find_files({hidden = true})'
  else
    nvim -c 'lua require(\'telescope.builtin\').find_files()'
  end
end

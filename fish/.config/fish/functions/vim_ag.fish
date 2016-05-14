function vim_ag -d "Open all files matching the search parameter"
  if test (count $argv) -ne 1
    echo 'Usage: vim_ag <search_pattern>'
    return
  end
  vim (ag -l $argv[1])
end

function github_open
  open https://(git config --get remote.origin.url | sed -e s/.git//g | sed s,:,/,g)/$argv
end

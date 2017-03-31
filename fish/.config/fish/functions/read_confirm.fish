# Taken from http://stackoverflow.com/a/39891882
function read_confirm --description 'Ask the user for confirmation' --argument prompt
  if test -z "$prompt"
    set prompt 'Continue?'
  end

  while true
    read -p 'set_color green; echo -n "$prompt [y/n]: "; set_color normal' -l confirm

    switch $confirm
      case Y y
        return 0
      case '' N n
        return 1
    end
    end
  end

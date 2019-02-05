function bopen -d "Open the URI with the default application in the background." --argument-names file verbose
  if test ! -e "$file"
    echo "File does not exist: $file"
    return 1
  end

  set -l application (xdg-mime query default (xdg-mime query filetype $file))
  if test -z "$application"
    echo "Could not find a default application for: $file"
    return 2
  end

  # Suppress usual GTK-related warnings by default
  if test -n "$verbose"
    gtk-launch "$application" "$file"
  else
    gtk-launch "$application" "$file" > /dev/null 2>&1
  end
end


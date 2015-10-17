# Returns 1 if the argument to this command matches the program name currently on the command line
function __fish_prog_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = $argv[1] ]
    return 0
  end
  return 1
end


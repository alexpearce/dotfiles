# Returns 1 if the argument to this command matches the subcommand currently on the command line
function __fish_prog_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end


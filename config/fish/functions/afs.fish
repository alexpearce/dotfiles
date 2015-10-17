function afs -d "Change to a directory in my AFS home/work area"
  if test (count $argv) -ne 2
    echo 'Usage: afs <home|work> <directory>'
    return
  end
  switch $argv[1]
  case home
    cd /afs/cern.ch/user/a/apearce/$argv[2]
  case work
    cd /afs/cern.ch/work/a/apearce/$argv[2]
  case '*'
    echo 'Subcommand "'$argv[1]'" unknown'
  end
end

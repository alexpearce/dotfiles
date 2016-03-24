set AFSHOME '/afs/cern.ch/user/a/apearce/'
set AFSWORK '/afs/cern.ch/work/a/apearce/'

# Takes first argument as one of home or work
complete --command afs --arguments 'home work' --authoritative

complete --command afs --exclusive \
  --condition '__fish_prog_using_command home' \
  --arguments '(__fish_complete_directories $AFSHOME/(commandline -ct) | sed -e "s#$AFSHOME##")'

complete --command afs --exclusive \
  --condition '__fish_prog_using_command work' \
  --arguments '(__fish_complete_directories $AFSWORK/(commandline -ct) | sed -e "s#$AFSWORK##")'

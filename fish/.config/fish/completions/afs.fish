set AFSHOME '/afs/cern.ch/user/a/apearce/'
set AFSWORK '/afs/cern.ch/work/a/apearce/'

complete -f -c afs -n '__fish_prog_needs_command afs' -a home
complete -c afs -n '__fish_prog_using_command home' -a '(__fish_complete_directories $AFSHOME | sed -e "s#$AFSHOME##")'

complete -f -c afs -n '__fish_prog_needs_command afs' -a work
complete -c afs -n '__fish_prog_using_command work' -a '(__fish_complete_directories $AFSWORK | sed -e "s#$AFSWORK##")'

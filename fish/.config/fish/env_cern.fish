# Shell set up specifically for CERN
set PATH ~/usr/bin ~/.local/bin /afs/cern.ch/sw/XML/texlive/latest/bin/x86_64-linux $PATH
set PATH $PATH /cvmfs/lhcb.cern.ch/lib/contrib/ninja/1.4.0/x86_64-slc6-gcc48-opt
set -x LD_LIBRARY_PATH ~/usr/lib:$LD_LIBRARY_PATH

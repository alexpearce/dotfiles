# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

#
# Ruby
#

export RBENV_ROOT=/usr/local/var/rbenv

#
# AFS
#

export AFS=/afs/cern.ch/user/a/apearce
export WORK=/afs/cern.ch/work/a/apearce
if [[ "`uname`" == "Darwin" ]]; then
  export SCRATCH=$HOME/Physics/Data
else
  export SCRATCH=/scratch/z5/apearce
fi

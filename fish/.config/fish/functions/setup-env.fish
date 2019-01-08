function setup-env -d "Set up persistant environment variables."
  if read_confirm 'Would you like me to set up a new environment?'

    echo 'Setting EDITOR and adding ~/.local/bin to PATH'
    set -e EDITOR
    set -U -x EDITOR nvim
    set -U fish_user_paths ~/.local/bin

    # Set up ROOT environment if we have Homebrew installed
    if command -s brew
      echo 'Setting environment for a brew\'d ROOT'
      set -U -x ROOTSYS (brew --prefix root6)
      set -U -x PYTHONPATH $ROOTSYS/lib/root
    end

    # Add local software, a more recent LaTeX distribution, and
    # the ninja build tool
    # We don't set LD_LIBRARY_PATH here because it may already have
    # a value that overrides any univeral value we set here; see env.fish for more
    if is_cern
      echo 'Setting CERN environment'
      set -U fish_user_paths ~/usr/bin ~/.local/bin /afs/cern.ch/sw/XML/texlive/latest/bin/x86_64-linux /cvmfs/lhcb.cern.ch/lib/contrib/ninja/1.4.0/x86_64-slc6-gcc48-opt $fish_user_paths
      set -U -x NINJAFLAGS -j6
    end

    echo 'Done!'
  else
    echo 'No problem, leaving everything as-is.'
  end
end

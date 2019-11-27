function mount_cvmfs
  for repo in (grep CVMFS_REPOSITORIES /etc/cvmfs/default.local | sed -E 's/.*=(.*)/\1/' | tr ',' '\n')
    sudo mkdir -p /cvmfs/$repo
    sudo mount -t cvmfs $repo /cvmfs/$repo
  end
end


function is_cern -d "Test whether host is a CERN machine"
  # Most CERN machines have a hostname ending in cern.ch
  test (hostname | grep -E cern\.ch)
  # But not the ones in the LHCb online network or my VMs
  or test (hostname | grep -E "(gw|plus|apv)[0-9]*")
end

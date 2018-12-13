function cern -d "Dynamically resolve a round-robin SSH target for Kerberos authentication"
  # Problem: OpenSSH no longer supports Kerberos authentication to hosts that 
  # load-balance with a round-robin technique.
  # Solution: Get resolved IP addresses from the load balancer dynamically, and 
  # modify the SSH configuration to use that IP address as the hostname of the 
  # SSH target.
  #
  # Example configuration template:
  #
  #   Host lxplus7
  #     # $ip is a placeholder that this function will fill
  #     HostName $ip
  #     GSSAPIAuthentication yes
  #     GSSAPIDelegateCredentials yes
  #
  #   Host lbgw
  #     ProxyJump lxplus7
  #
  #   Host plus
  #     ProxyJump lbgw
  #
  #  Then SSH to lxplus with `cern`, or to lbgw (a node *behind* the load 
  #  balancer) with `cern lbgw`.

  # Path to SSH configuration template.
  # Should contain the token '$ip' which will be replaced with an
  # IP address from the lxplus7.cern.ch DNS record.
  set ssh_config_template ~/.ssh/lxplus.tpl
  # Path for the completed template
  set ssh_config ~/.ssh/lxplus
  # Address of the load balancer that we need to get a IP address from
  set load_balancer lxplus7.cern.ch
  # Hostname to log in to if none is specified
  set default_host lxplus7.cern.ch
  # Token to identify a configuration file that *we* created.
  # We'll bail if ssh_config doesn't start with this line
  set first_line '# Auto-generated on'

  # Make sure we have a Kerberos token
  if not klist -s
    echo '🔐 Renewing Kerberos token'
    if not kinit -f -l 24h apearce@CERN.CH
      return 1
    end
  end

  if test -e $ssh_config_template
    # Don't want to overwrite a hand-written config
    if test -e $ssh_config; and not head -n 1 $ssh_config | grep -q "^$first_line"
      echo "SSH configuration does not appear auto-generated: $ssh_config"
      return 1
    end

    set ip (host $load_balancer | head -n 1 | awk '{ print $4 }')
    echo $first_line (date) > $ssh_config
    sed "s/\$ip/$ip/g" $ssh_config_template >> $ssh_config
  else
    echo "Could not find SSH configuration template: $ssh_config_template"
    return 1
  end

  # Figure out the hostname we want the log in into
  if not count $argv > /dev/null
    set hostname $default_host
  else
    set hostname $argv
  end

  ssh -K -oProxyJump=$default_host $hostname
end

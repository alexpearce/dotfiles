function ktmux -d "Launch tmux, inside a Kerberos session if at CERN"
  if is_cern
    pagsh.krb -c 'kinit && tmux'
  else
    tmux
  end
end

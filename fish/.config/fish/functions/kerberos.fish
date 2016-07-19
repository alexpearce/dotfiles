function kerberos -d "Get Kerberos and AFS token valid for 24 hours"
  if security find-generic-password -s kerberos-alex-pearce-cern-ch -w | kinit -l 24h --password-file=STDIN apearce@CERN.CH
    klist
  end
end

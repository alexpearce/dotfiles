function kerberos -d "Get Kerberos and AFS token valid for 24 hours"
  if kinit -l 24h apearce@CERN.CH
    aklog
    klist
  end
end

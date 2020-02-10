# Auto-generate a Kerberos token when needed, if possible
# Place a keytab file at $HOME/.$USER.keytab to enable
set -l keytab_path $HOME/.$USER.keytab
if not klist -t
  if not test -f "$keytab_path"
    echo "🔓 You do not have a Kerberos token and I couldn't find a keytab at $keytab_path"
  else
    kinit -kt "$keytab_path"
  end
end

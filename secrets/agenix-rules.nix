# Which personal keys each secret is encrypted to.
let
  keys = import ./keys.nix;
  personal = builtins.filter (s: s != "" && builtins.isString s) (
    builtins.split "\n" (builtins.readFile keys.personal)
  );
  trusted = personal ++ [
    keys.hosts.kazooie
    keys.hosts.pearwin-laptop
  ];
in
{
  "opencode.age".publicKeys = trusted;
  "pearwinternet.age".publicKeys = trusted;
}

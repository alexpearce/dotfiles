let
  me = builtins.filter (s: s != "" && builtins.isString s) (
    builtins.split "\n" (
      builtins.readFile (
        builtins.fetchurl {
          url = "https://github.com/alexpearce.keys";
          sha256 = "sha256:1q0by72d41yqix3a1f2aj94mjgb4n0vzb6rb90is5j92aw3ql43s";
        }
      )
    )
  );

  kazooie = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHN9Xv3cmHDrToDzjoBCgP4thIzMwl/Tg4b60pLBaH4";
  pearwin-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJIlmdBr/aP5r3wjEucJxZiahG+VmT/zBJ3DF7hLgqM3";

  trusted = me ++ [
    kazooie
    pearwin-laptop
  ];
in
{
  "opencode.age".publicKeys = trusted;
  "pearwinternet.age".publicKeys = trusted;
}

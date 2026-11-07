# Nix itself.
{
  flake.modules.nixos.nix = {
    nix.extraOptions = ''
      experimental-features = nix-command flakes
    '';
    nix.gc.automatic = true;
  };
}

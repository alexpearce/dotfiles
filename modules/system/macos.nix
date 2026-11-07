# macOS basics.
{
  flake.modules.darwin.macos =
    { pkgs, ... }:
    {
      # Make nix available to the default macOS shell.
      programs.zsh.enable = true;

      fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

      # Our Nix installation is managed by the Determinate Systems installer.
      nix.enable = false;
    };
}

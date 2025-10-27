{pkgs, ...}: let
  username = "apearwin";
  homeDirectory = "/Users/${username}";
in {
  users.users."${username}" = {
    home = homeDirectory;
  };

  # Make nix available to default macOS shell.
  programs.zsh.enable = true;
  # Expose nix-provided paths to fish.
  programs.fish.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${username}" = {
      imports = [./home.nix];
      home = {
        inherit homeDirectory username;
        stateVersion = "23.11";
      };
    };
  };

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  # Our Nix installation is managed by the Determinate Systems installer.
  nix.enable = false;

  system.stateVersion = 4;
}

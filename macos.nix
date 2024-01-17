{pkgs, ...}: let
  username = "alex.pearce";
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
      };
    };
  };

  fonts = {
    fontDir.enable = true;
    fonts = [
      (pkgs.nerdfonts.override {
        fonts = [
          "JetBrainsMono"
        ];
      })
    ];
  };

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '';

  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}

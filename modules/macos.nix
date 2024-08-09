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
    (pkgs.nerdfonts.override {
      fonts = [
        "JetBrainsMono"
      ];
    })
  ];

  nix.extraOptions = ''
    # Settings copied from those written by
    # https://github.com/DeterminateSystems/nix-installer, version 0.11.0.
    extra-nix-path = nixpkgs=flake:nixpkgs
    bash-prompt-prefix = (nix:$name)\040
    experimental-features = nix-command flakes auto-allocate-uids
    build-users-group = nixbld
  '';
  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}

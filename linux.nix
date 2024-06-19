{
  pkgs,
  inputs,
  ...
}: let
  username = "apearwin";
  homeDirectory = "/home/${username}";
in {
  imports = [
    ./hosts/vm-utm/hardware-configuration.nix
    # "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    inputs.disko.nixosModules.disko
    ./hosts/vm-utm/disko-configuration.nix
    ./hosts/vm-utm/configuration.nix
  ];

  programs.fish.enable = true;
  programs.firefox.enable = true;

  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    home = homeDirectory;
    shell = pkgs.fish;
  };

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

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

  nix.settings.experimental-features = "nix-command flakes";
}

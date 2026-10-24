{
  pkgs,
  lib,
  ...
}:
let
  publicKeys = builtins.fetchurl {
    url = "https://github.com/alexpearce.keys";
    sha256 = "sha256:1q0by72d41yqix3a1f2aj94mjgb4n0vzb6rb90is5j92aw3ql43s";
  };
in
{
  i18n.defaultLocale = "en_GB.UTF-8";

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    optimise = {
      automatic = true;
      dates = [ "12:00" ];
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 10d";
    };
  };

  security.sudo.wheelNeedsPassword = false;

  services.openssh.enable = true;

  time.timeZone = "Europe/London";

  users = {
    mutableUsers = false;
    users.apearwin = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "audio"
        "video"
        "input"
      ];
      packages = with pkgs; [
        bottom
        dig
        fd
        helix
        ripgrep
        tree
      ];
      openssh.authorizedKeys.keyFiles = [ publicKeys ];
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:
{
  age.secrets.pearwinternet.file = ../../secrets/pearwinternet.age;

  boot = {
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-deckify;
    loader.systemd-boot.enable = true;
  };

  environment.systemPackages = with pkgs; [
    firefox
    ryzenadj
  ];

  hardware = {
    facter.reportPath = ./facter.json;

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  jovian = {
    steam = {
      enable = true;
      autoStart = true;
      user = "apearwin";
      desktopSession = "plasma";
    };
    hardware.has.amd.gpu = true;
    decky-loader = {
      enable = true;
      extraPackages = with pkgs; [
        python3
      ];
    };
  };

  # Plugin subprocesses fork from the decky-loader service and inherit its
  # environment. HueSync loads libhidapi at runtime to drive the Ally X RGB
  # LEDs; the Jovian module only adds extraPackages to PATH, so expose the
  # library via LD_LIBRARY_PATH.
  systemd.services.decky-loader.environment.LD_LIBRARY_PATH = lib.makeLibraryPath (
    with pkgs; [ hidapi ]
  );

  networking = {
    hostName = "kazooie";
    networkmanager = {
      enable = true;
      ensureProfiles = {
        environmentFiles = [
          config.age.secrets.pearwinternet.path
        ];
        profiles = {
          "Pearwinternet" = {
            connection = {
              id = "Pearwinternet";
              type = "wifi";
              autoconnect = "true";
            };
            wifi = {
              ssid = "Pearwinternet";
              mode = "infrastructure";
            };
            wifi-security = {
              key-mgmt = "wpa-psk";
              psk = "$WIFI_PASSWORD";
            };
            ipv4.method = "auto";
            ipv6.method = "auto";
          };
        };
      };
    };
  };

  nixpkgs.config.allowUnfree = true;

  services = {
    asusd.enable = true;

    desktopManager.plasma6.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  system.stateVersion = "26.05";

  # https://github.com/Jovian-Experiments/Jovian-NixOS/issues/460#issuecomment-3439375088
  systemd.services.steam-cef-debug = lib.mkIf config.jovian.decky-loader.enable {
    description = "Create Steam CEF debugging file";
    serviceConfig = {
      Type = "oneshot";
      User = config.jovian.steam.user;
      ExecStart = "/bin/sh -c 'mkdir -p ~/.steam/steam && [ ! -f ~/.steam/steam/.cef-enable-remote-debugging ] && touch ~/.steam/steam/.cef-enable-remote-debugging || true'";
    };
    wantedBy = [ "multi-user.target" ];
  };
}

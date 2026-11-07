# Asus ROG Xbox Ally X: a handheld gaming device.
#
# Deploy with `colmena apply --on kazooie`.
{ config, inputs, ... }:
let
  me = config.owner;
in
{
  hosts.kazooie = {
    system = "x86_64-linux";
    # A separate follower of nixos-unstable so that this machine can be
    # updated independently of the others.
    nixpkgs = inputs.nixpkgs-kazooie;
    deployment = {
      buildOnTarget = true;
      targetHost = "kazooie";
      targetUser = me.username;
    };
  };

  flake.modules.nixos.kazooie =
    { lib, pkgs, ... }:
    {
      imports = with config.flake.modules.nixos; [
        inputs.disko.nixosModules.disko
        ./_disko.nix

        agenix
        cachyos-kernel
        colmena-target
        locale
        nix
        nixpkgs
        owner
        steam-deck-ui
        wifi
      ];

      networking.hostName = "kazooie";

      boot.loader.systemd-boot.enable = true;

      hardware.facter.reportPath = ./facter.json;

      jovian.hardware.has.amd.gpu = true;
      services.asusd.enable = true;

      # Plugin subprocesses fork from the decky-loader service and inherit its
      # environment. HueSync loads libhidapi at runtime to drive the Ally X RGB
      # LEDs; the Jovian module only adds extraPackages to PATH, so expose the
      # library via LD_LIBRARY_PATH.
      systemd.services.decky-loader.environment.LD_LIBRARY_PATH = lib.makeLibraryPath (
        with pkgs; [ hidapi ]
      );

      environment.systemPackages = with pkgs; [
        firefox
        ryzenadj
      ];

      services.openssh.enable = true;

      users.users.${me.username} = {
        extraGroups = [
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
        openssh.authorizedKeys.keyFiles = [ me.authorizedKeysFile ];
      };

      nix = {
        optimise = {
          automatic = true;
          dates = [ "12:00" ];
        };
        gc = {
          dates = "daily";
          options = "--delete-older-than 10d";
        };
      };

      system.stateVersion = "26.05";
    };
}

# SteamOS-like gaming session via Jovian, booting straight into Steam's Game
# Mode with Plasma as the desktop session, and Decky Loader for plugins.
{ config, inputs, ... }:
let
  inherit (config.owner) username;
in
{
  flake.modules.nixos.steam-deck-ui =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [ inputs.jovian.nixosModules.default ];

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      jovian = {
        steam = {
          enable = true;
          autoStart = true;
          user = username;
          desktopSession = "plasma";
        };
        decky-loader = {
          enable = true;
          extraPackages = with pkgs; [
            python3
          ];
        };
      };

      services = {
        desktopManager.plasma6.enable = true;
        displayManager.sddm = {
          enable = true;
          wayland.enable = true;
        };
      };

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
    };
}

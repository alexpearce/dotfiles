# macOS window management.
#
# Tell Hammerspoon where its configuration lives:
#   defaults write org.hammerspoon.Hammerspoon MJConfigFile "${XDG_CONFIG_HOME:-$HOME/.config}/hammerspoon/init.lua"
{
  flake.modules.homeManager.hammerspoon =
    { lib, pkgs, ... }:
    lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
      xdg.configFile.hammerspoon = {
        source = ./hammerspoon;
        recursive = true;
      };
    };
}

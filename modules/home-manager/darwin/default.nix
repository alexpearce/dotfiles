{
  config,
  pkgs,
  lib,
  ...
}:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  config = lib.mkIf isDarwin {
    home = {
      packages = with pkgs; [
        colima
        docker
      ];
    };

    programs = {
      fish = {
        plugins = [
          # Need this when using Fish as a default macOS shell in order to pick
          # up ~/.nix-profile/bin
          {
            name = "nix-env";
            src = pkgs.fetchFromGitHub {
              owner = "lilyball";
              repo = "nix-env.fish";
              rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
              sha256 = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
            };
          }
        ];
      };

      git = {
        settings = {
          core = {
            # If git uses `ssh` from Nix the macOS-specific configuration in
            # `~/.ssh/config` won't be seen as valid
            # https://github.com/NixOS/nixpkgs/issues/15686#issuecomment-865928923
            sshCommand = "/usr/bin/ssh";
          };
        };
      };

      ghostty = {
        # Ghostty package is broken on macOS, must install app manually.
        package = null;
      };
    };

    # Requires telling Hammerspoon to look for configuration in the right place:
    #   defaults write org.hammerspoon.Hammerspoon MJConfigFile "${XDG_CONFIG_HOME:-$HOME/.config}/hammerspoon/init.lua"
    xdg.configFile.hammerspoon = {
      source = ./hammerspoon;
      recursive = true;
    };
  };
}

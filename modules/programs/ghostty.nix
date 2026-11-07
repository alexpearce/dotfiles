# Terminal emulator; macOS uses the separately installed application.
{
  flake.modules.homeManager.ghostty =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
          programs.ghostty.package = null;
        })
      ];
      programs = {
        ghostty = {
          enable = true;
          settings = {
            theme = "TokyoNight Moon";
            command = "${config.home.profileDirectory}/bin/fish";
            # Move between panes with cmd+opt+{h,j,k,l}.
            keybind = [
              "cmd+opt+h=goto_split:left"
              "cmd+opt+j=goto_split:bottom"
              "cmd+opt+k=goto_split:top"
              "cmd+opt+l=goto_split:right"
              # Close the current surface with cmd+shift+w.
              "global:cmd+shift+w=close_surface"
            ];
            font-family = "Iosevka Term";
            font-feature = "+dlig";
            font-style = "Medium";
            font-style-bold = "Bold";
            font-style-italic = "Medium Italic";
            font-style-bold-italic = "Bold Italic";
            font-size = 16;
            # 256 MiB.
            scrollback-limit = 268435456;
          };
        };
      };
    };
}

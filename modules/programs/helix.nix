# Default editor.
{
  flake.modules.homeManager.helix =
    { lib, ... }:
    {
      home.sessionVariables.EDITOR = "hx";
      programs = {
        helix = {
          enable = true;
          settings = {
            theme = lib.mkDefault "tokyonight_moon";
            editor = {
              bufferline = "multiple";
              color-modes = true;
              line-number = "relative";
              lsp.display-messages = true;
            };
            keys.normal = {
              space.w = ":w";
              space.q = ":q";
              space.x = ":x";
            };
          };
          languages.language = [
            {
              name = "elixir";
              auto-format = true;
            }
          ];
        };
      };
    };
}

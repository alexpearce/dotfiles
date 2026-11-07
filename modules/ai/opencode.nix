# OpenCode, using models from OpenRouter.
{ config, ... }:
let
  inherit (config.owner) username;
in
{
  flake.modules.homeManager.opencode.programs.opencode = {
    enable = true;
    settings.model = "openrouter/deepseek/deepseek-v4.1-flash-1017";
  };

  flake.modules.darwin.opencode =
    { config, ... }:
    let
      keyPath = config.age.secrets.opencode.path;
    in
    {
      age.secrets.opencode = {
        file = ../../secrets/opencode.age;
        owner = username;
        mode = "0400";
      };

      home-manager.sharedModules = [
        {
          programs.fish.interactiveShellInit = ''
            if test -r ${keyPath}
              set -gx OPENROUTER_API_KEY (string trim < ${keyPath})
            end
          '';
        }
      ];
    };
}

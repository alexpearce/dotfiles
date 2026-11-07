{ config, ... }:
{
  flake.modules.homeManager.git =
    { lib, pkgs, ... }:
    {
      imports = [
        (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
          # Use macOS SSH so that macOS-specific ~/.ssh/config is valid.
          # https://github.com/NixOS/nixpkgs/issues/15686#issuecomment-865928923
          programs.git.settings.core.sshCommand = "/usr/bin/ssh";
        })
      ];

      programs.git = {
        enable = true;
        settings = {
          alias = {
            prettylog = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
          };
          color = {
            ui = true;
          };
          diff = {
            colorMoved = "default";
          };
          merge = {
            conflictstyle = "zdiff3";
          };
          push = {
            default = "current";
          };
          pull = {
            ff = "only";
          };
          init = {
            defaultBranch = "main";
          };
          user.email = config.owner.email;
          user.name = config.owner.fullName;
          # Clone git repos with URLs like "gh:alexpearce/dotfiles"
          url."git@github.com:" = {
            insteadOf = "gh:";
            pushInsteadOf = "gh:";
          };
        };
        ignores = [
          ".*.swp"
          ".bundle"
          "vendor/bundle"
          ".DS_Store"
          "Icon"
          "*.pyc"
          ".direnv"
        ];
      };
    };
}

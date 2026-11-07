# Personal MacBook.
{ config, ... }:
{
  hosts.pearwin-laptop.system = "aarch64-darwin";

  flake.modules.darwin.pearwin-laptop = {
    imports = with config.flake.modules.darwin; [
      agenix
      home-manager
      macos
      nixpkgs
      owner
      bat
      cli-tools
      delta
      direnv
      eza
      fish
      fzf
      gh
      ghostty
      git
      hammerspoon
      helix
      starship
      zoxide
      docker
      opencode
    ];

    home-manager.users.${config.owner.username}.home = {
      username = config.owner.username;
      homeDirectory = "/Users/${config.owner.username}";
      stateVersion = "23.11";
    };
    system.stateVersion = 4;
  };
}

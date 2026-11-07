# Standalone Home Manager profiles, using the same features as the MacBook.
{
  config,
  inputs,
  lib,
  ...
}:
let
  features = with config.flake.modules.homeManager; [
    home-manager
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
  profiles = {
    apearwin = {
      system = "aarch64-darwin";
      username = config.owner.username;
      homeDirectory = "/Users/${config.owner.username}";
    };
    apearwin-ci = {
      system = "x86_64-linux";
      username = "runner";
      homeDirectory = "/home/runner";
    };
  };
in
{
  options.flake.homeConfigurations = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = { };
    description = "Standalone Home Manager configurations.";
  };

  config.flake.modules.homeManager = lib.mapAttrs (_: profile: {
    imports = features;
    home = {
      inherit (profile) username homeDirectory;
      stateVersion = "23.11";
    };
  }) profiles;

  config.flake.homeConfigurations = lib.mapAttrs (
    name: profile:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${profile.system};
      modules = [ config.flake.modules.homeManager.${name} ];
    }
  ) profiles;

  config.flake.checks = lib.foldlAttrs (
    acc: name: profile:
    lib.recursiveUpdate acc {
      ${profile.system}."home-${name}" = config.flake.homeConfigurations.${name}.activationPackage;
    }
  ) { } profiles;
}

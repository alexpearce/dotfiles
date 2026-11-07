# Home Manager, integrated into the system configuration.
{ inputs, ... }:
let
  settings = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
in
{
  flake.modules.homeManager.home-manager = {
    programs.home-manager.enable = true;
  };

  flake.modules.nixos.home-manager.imports = [
    inputs.home-manager.nixosModules.home-manager
    settings
  ];

  flake.modules.darwin.home-manager.imports = [
    inputs.home-manager.darwinModules.home-manager
    settings
  ];
}

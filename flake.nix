{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
    }:
    let
      makeHomeManagerConfiguration =
        {
          system,
          username,
          homeDirectory ? "/Users/${username}",
        }:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./modules/home-manager
            {
              home = {
                inherit homeDirectory username;
                stateVersion = "23.11";
              };
            }
          ];
        };
    in
    {
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-tree;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
      homeConfigurations.apearwin = makeHomeManagerConfiguration {
        system = "aarch64-darwin";
        username = "apearwin";
      };
      homeConfigurations.apearwin-ci = makeHomeManagerConfiguration {
        system = "x86_64-linux";
        username = "runner";
        homeDirectory = "/home/runner";
      };
      darwinConfigurations.pearwin-laptop = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          home-manager.darwinModules.home-manager
          ./modules/macos.nix
        ];
      };
    };
}

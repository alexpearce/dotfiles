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
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    disko,
  } @ inputs: let
    makeHomeManagerConfiguration = {
      system,
      username,
      homeDirectory ? "/Users/${username}",
    }: let
      pkgs = nixpkgs.legacyPackages.${system};
    in
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
          {
            home = {
              inherit homeDirectory username;
              stateVersion = "23.11";
            };
          }
        ];
      };
  in {
    formatter.aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.alejandra;
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    homeConfigurations.apearwin = makeHomeManagerConfiguration {
      system = "aarch64-darwin";
      username = "apearwin";
    };
    homeConfigurations.apearwin-ci = makeHomeManagerConfiguration {
      system = "x86_64-linux";
      username = "runner";
      homeDirectory = "/home/runner";
    };
    nixosConfigurations.vm-utm = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./linux.nix
        home-manager.nixosModules.home-manager
      ];
    };
    darwinConfigurations.pearwin-laptop = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./macos.nix
        home-manager.darwinModules.home-manager
      ];
    };
  };
}

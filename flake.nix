{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
  } @ inputs: let
    makeHomeManagerConfiguration = {
      system,
      username,
      homeDirectory ? "/Users/${username}",
    }: let
      pkgs = import nixpkgs {inherit system;};
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
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    homeConfigurations.apearwin = makeHomeManagerConfiguration {
      system = "aarch64-darwin";
      username = "apearwin";
    };
    homeConfigurations.apearwin-work = makeHomeManagerConfiguration {
      system = "aarch64-darwin";
      username = "alex.pearce";
    };
    homeConfigurations.apearwin-ci = makeHomeManagerConfiguration {
      system = "x86_64-linux";
      username = "runner";
      homeDirectory = "/home/runner";
    };
    nixosConfigurations.testbench = let
      system = "aarch64-linux";
    in
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.apearwin = makeHomeManagerConfiguration {
              inherit system;
              username = "apearwin";
              homeDirectory = "/home/apearwin";
            };
          }
        ];
      };
  };
}

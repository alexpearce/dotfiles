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

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
  }: let
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
    # `nix run nix-darwin -- switch --flake (pwd)`
    darwinConfigurations.MULTIVLAP1087 = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./macos.nix
        home-manager.darwinModules.home-manager
      ];
    };
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
  };
}

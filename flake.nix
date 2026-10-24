{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-os-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # A different follower of nixos-unstable so that different machines can
    # evolve at different times.
    nixpkgs-handheld.url = "github:NixOS/nixpkgs/nixos-unstable";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs-os-unstable";
    };
    jovian = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs-os-unstable";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
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
      nixpkgs-handheld,
      agenix,
      disko,
      jovian,
      nix-cachyos-kernel,
      nix-darwin,
      home-manager,
      ...
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
      nixosConfigurations = {
        # Asus ROG Xbox Ally X.
        # To rebuild:
        #
        #   nix run nixpkgs#nixos-rebuild -- switch --flake .#kazooie \
        #     --target-host apearwin@kazooie --build-host apearwin@kazooie --sudo
        kazooie = nixpkgs-handheld.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            agenix.nixosModules.default
            disko.nixosModules.disko
            jovian.nixosModules.default
            (
              { ... }:
              {
                nixpkgs.overlays = [
                  nix-cachyos-kernel.overlays.pinned
                ];
              }
            )
            (
              { ... }:
              {
                nix.settings.substituters = [ "https://cache.lantian.pub/lantian" ];
                nix.settings.trusted-public-keys = [ "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ=" ];

              }
            )
            ./hosts/kazooie
          ];
        };
      };
    };
}

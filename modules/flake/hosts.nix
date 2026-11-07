# Turns `hosts.<name>` declarations into system configurations.
#
# A host is the module `flake.modules.<class>.<name>`, where class is `nixos`
# or `darwin`; any number of files may contribute to it. `hosts.<name>` only
# carries what cannot live inside that module: the platform, which nixpkgs to
# evaluate with, and how to deploy it.
#
# NixOS hosts appear both in `nixosConfigurations` (for nixos-rebuild,
# nixos-anywhere, and checks) and in `colmenaHive` (for deployment). Both
# evaluate to the same system.
{
  config,
  inputs,
  lib,
  ...
}:
let
  inherit (lib) mkOption types;

  hostType = types.submodule (
    { name, config, ... }:
    {
      options = {
        system = mkOption {
          type = types.enum [
            "aarch64-darwin"
            "aarch64-linux"
            "x86_64-linux"
          ];
          description = "Platform the host runs on.";
        };
        class = mkOption {
          type = types.enum [
            "nixos"
            "darwin"
          ];
          readOnly = true;
          default = if lib.hasSuffix "-darwin" config.system then "darwin" else "nixos";
          description = "Module class, derived from the platform.";
        };
        nixpkgs = mkOption {
          type = types.raw;
          default = inputs.nixpkgs;
          description = ''
            nixpkgs flake to build NixOS hosts with. nix-darwin hosts always use
            the nixpkgs that the nix-darwin input follows.
          '';
        };
        deployment = mkOption {
          type = types.attrsOf types.anything;
          default = { };
          description = "Colmena `deployment` options (NixOS hosts only).";
        };
        module = mkOption {
          type = types.deferredModule;
          readOnly = true;
          default = flakeConfig.flake.modules.${config.class}.${name};
          defaultText = lib.literalExpression "config.flake.modules.<class>.<name>";
          description = "The host's top-level module.";
        };
      };
    }
  );

  flakeConfig = config;

  hostsOfClass = class: lib.filterAttrs (_: host: host.class == class) config.hosts;

  # `nixosSystem` sets these from the nixpkgs flake; Colmena evaluates through
  # `eval-config.nix` directly and would otherwise build a system with
  # different version metadata.
  nixpkgsFlakeMetadata = nixpkgs: {
    nixpkgs.flake.source = nixpkgs.outPath;
    system.nixos.versionSuffix = ".${lib.substring 0 8 nixpkgs.lastModifiedDate}.${nixpkgs.shortRev}";
    system.nixos.revision = nixpkgs.rev;
  };
in
{
  options = {
    hosts = mkOption {
      type = types.attrsOf hostType;
      default = { };
      description = "Machines managed by this flake.";
    };
    flake.darwinConfigurations = mkOption {
      type = types.lazyAttrsOf types.raw;
      default = { };
    };
  };

  config.flake = {
    nixosConfigurations = lib.mapAttrs (
      _name: host:
      host.nixpkgs.lib.nixosSystem {
        inherit (host) system;
        modules = [ host.module ];
      }
    ) (hostsOfClass "nixos");

    darwinConfigurations = lib.mapAttrs (
      _name: host:
      inputs.nix-darwin.lib.darwinSystem {
        inherit (host) system;
        modules = [ host.module ];
      }
    ) (hostsOfClass "darwin");

    colmenaHive =
      let
        nixosHosts = hostsOfClass "nixos";
        importNixpkgs = host: import host.nixpkgs { inherit (host) system; };
      in
      inputs.colmena.lib.makeHive (
        {
          meta = {
            # Colmena requires a default even though every node sets its own.
            nixpkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
            nodeNixpkgs = lib.mapAttrs (_: importNixpkgs) nixosHosts;
          };
        }
        // lib.mapAttrs (_: host: {
          imports = [
            host.module
            (nixpkgsFlakeMetadata host.nixpkgs)
          ];
          inherit (host) deployment;
        }) nixosHosts
      );
  };
}

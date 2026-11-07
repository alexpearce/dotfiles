# nixpkgs settings shared by every host.
#
# Adds two package sets to `pkgs`:
#
# - `pkgs.unstable`: the `nixpkgs-ai` input, for tools that should be
#   updated independently of the rest of the system (e.g. AI agents);
# - `pkgs.local`: packages defined in this repository via `localPackages`.
{
  config,
  inputs,
  lib,
  ...
}:
let
  overlay = final: prev: {
    unstable = import inputs.nixpkgs-ai {
      inherit (final.stdenv.hostPlatform) system;
      inherit (final) config;
    };
    local = lib.mapAttrs (_: package: final.callPackage package { }) config.localPackages;
  };

  module = {
    nixpkgs.overlays = [ overlay ];
    nixpkgs.config.allowUnfree = true;
  };
in
{
  options.localPackages = lib.mkOption {
    type = lib.types.attrsOf lib.types.raw;
    default = { };
    description = "Packages, as `callPackage`-able functions, exposed as `pkgs.local.<name>`.";
  };

  config.flake.modules.nixos.nixpkgs = module;
  config.flake.modules.darwin.nixpkgs = module;
}

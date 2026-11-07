# Make every Home Manager aspect importable by NixOS and nix-darwin hosts.
#
# A file that defines `flake.modules.homeManager.<name>` therefore also
# provides `flake.modules.{nixos,darwin}.<name>`, which adds the Home Manager
# module to every Home Manager user on the host. A file may also define
# `flake.modules.{nixos,darwin}.<name>` itself for system-level or
# platform-specific parts of the same aspect; the definitions merge.
#
# Hosts importing such aspects must also import the `home-manager` aspect.
{ config, lib, ... }:
let
  bridged = lib.mapAttrs (_: module: {
    home-manager.sharedModules = [ module ];
  }) config.flake.modules.homeManager;
in
{
  flake.modules.nixos = bridged;
  flake.modules.darwin = bridged;
}

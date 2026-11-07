# `nix flake check` evaluates every host. Each host's check is its
# top-level system derivation, filed under the platform it runs on.
#
# `nix flake check --all-systems` checks hosts of every platform;
# add `--no-build` to only evaluate, which is enough to catch most errors.
{ config, lib, ... }:
let
  toplevel =
    name: host:
    if host.class == "darwin" then
      config.flake.darwinConfigurations.${name}.system
    else
      config.flake.nixosConfigurations.${name}.config.system.build.toplevel;
in
{
  flake.checks = lib.foldlAttrs (
    acc: name: host:
    lib.recursiveUpdate acc { ${host.system}.${name} = toplevel name host; }
  ) { } config.hosts;
}

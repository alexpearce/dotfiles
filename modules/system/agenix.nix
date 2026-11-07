# System-level secrets.
{ inputs, ... }:
{
  flake.modules.nixos.agenix.imports = [ inputs.agenix.nixosModules.default ];
  flake.modules.darwin.agenix.imports = [ inputs.agenix.darwinModules.default ];
}

# The person these machines belong to, and their user account.
{ config, lib, ... }:
let
  inherit (lib) mkOption types;
  inherit (config.owner) username;
in
{
  options.owner = {
    username = mkOption { type = types.str; };
    fullName = mkOption { type = types.str; };
    email = mkOption { type = types.str; };
    authorizedKeysFile = mkOption {
      type = types.path;
      description = "File of SSH public keys allowed to log in as the owner.";
    };
  };

  config.owner = {
    username = "apearwin";
    fullName = "Alex Pearwin";
    email = "alex@pearwin.com";
    authorizedKeysFile = (import ../../secrets/keys.nix).personal;
  };

  config.flake.modules.nixos.owner.users = {
    mutableUsers = false;
    users.${username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

  config.flake.modules.darwin.owner.users.users.${username}.home = "/Users/${username}";
}

# Hosts deployed with Colmena: the deployment user must be able to activate
# the system without a password prompt.
{
  flake.modules.nixos.colmena-target = {
    security.sudo.wheelNeedsPassword = false;
  };
}

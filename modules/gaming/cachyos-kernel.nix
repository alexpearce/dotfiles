# The CachyOS kernel, tuned for gaming and handhelds.
{ inputs, ... }:
{
  flake.modules.nixos.cachyos-kernel =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];

      nix.settings.substituters = [ "https://cache.lantian.pub/lantian" ];
      nix.settings.trusted-public-keys = [ "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ=" ];

      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-deckify;
    };
}

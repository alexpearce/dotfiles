# Docker, with a Colima VM providing the daemon on macOS.
{
  flake.modules.homeManager.docker =
    { lib, pkgs, ... }:
    lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
      home.packages = with pkgs; [
        colima
        docker
      ];
    };
}

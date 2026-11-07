{ inputs, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    {
      formatter = pkgs.nixfmt-tree;

      devShells.default = pkgs.mkShell {
        packages = [
          inputs.colmena.packages.${system}.colmena
          inputs.agenix.packages.${system}.default
        ];
      };
    };
}

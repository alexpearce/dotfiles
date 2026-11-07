# Assorted command-line tools without further configuration.
{
  flake.modules.homeManager.cli-tools =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        entr
        fd
        httpie
        hyperfine
        imagemagick
        jq
        nodejs
        pandoc
        python3
        ripgrep
        tree
        tree-sitter
      ];
    };
}

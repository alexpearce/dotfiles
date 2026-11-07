{
  flake.modules.homeManager.fzf.programs.fzf = {
    enable = true;
    # The fzf.fish plugin provides the integration instead; see fish.nix.
    enableFishIntegration = false;
  };
}

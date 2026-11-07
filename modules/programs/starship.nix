{
  flake.modules.homeManager.starship.programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      elixir.disabled = true;
      nodejs.disabled = true;
      nix_shell.disabled = true;
      package.disabled = true;
      docker_context.disabled = true;
      git_branch.format = "[$branch(:$remote_branch)]($style) ";
    };
  };
}

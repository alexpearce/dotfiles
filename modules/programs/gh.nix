{
  flake.modules.homeManager.gh.programs.gh = {
    enable = true;
    settings = {
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
      git_protocol = "ssh";
    };
  };
}

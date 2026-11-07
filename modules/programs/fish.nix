# Default interactive shell, including standalone Home Manager on macOS.
{
  flake.modules.homeManager.fish =
    { lib, pkgs, ... }:
    {
      imports = [
        (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
          # Make Nix-provided paths available when fish is the login shell.
          programs.fish.plugins = [
            {
              name = "nix-env";
              src = pkgs.fetchFromGitHub {
                owner = "lilyball";
                repo = "nix-env.fish";
                rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
                sha256 = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
              };
            }
          ];
        })
      ];
      programs = {
        fish = {
          enable = true;
          plugins = [
            {
              name = "fzf";
              src = pkgs.fetchFromGitHub {
                owner = "PatrickF1";
                repo = "fzf.fish";
                rev = "8920367cf85eee5218cc25a11e209d46e2591e7a";
                sha256 = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
              };
            }
          ];
          shellAliases = {
            rm = "rm -i";
            cp = "cp -i";
            mv = "mv -i";
            mkdir = "mkdir -p";
            du = "du -hs";
          };
          # Abbreviate commonly used functions
          # An abbreviation will expand after <space> or <Enter> is hit
          shellAbbrs = {
            b = "bat";
            g = "git";
            ga = "git add";
            gap = "git add -p";
            gb = "git branch";
            gc = "git commit";
            gca = "git commit --amend";
            gcan = "git commit --amend --no-edit";
            gcm = "git commit -m";
            gcl = "git clone";
            gd = "git diff";
            gds = "git diff --staged";
            gl = "git prettylog";
            gp = "git push";
            gpf = "git push --force-with-lease";
            gpl = "git pull";
            gplp = "git pull --prune";
            gr = "git restore";
            grs = "git restore --staged";
            grb = "git rebase";
            grba = "git rebase --abort";
            grbc = "git rebase --continue";
            grbi = "git rebase -i";
            gs = "git status -s -b";
            gst = "git stash";
            gstp = "git stash pop";
            gsts = "git stash show -p";
            gstx = "git stash drop";
            gsw = "git switch";
            gswc = "git switch -c";
            gswm = "git switch main";
            h = "http";
            iexm = "iex -S mix";
            m = "make";
            o = "open";
            p = "python3";
          };
          functions = {
            ctrlp = {
              description = "Launch Helix file finder from the shell";
              argumentNames = "hidden";
              body = ''
                if test -n "$hidden"
                  # TODO can't find a way to toggle hidden files in Helix yet
                  echo 'Hidden searching not yet supported.'
                  exit 1
                else
                  hx .
                end
              '';
            };
            fish_greeting = {
              description = "Greeting to show when starting a fish shell";
              body = "";
            };
            fish_user_key_bindings = {
              description = "Set custom key bindings";
              body = ''
                bind \cp ctrlp
                bind \cl 'ctrlp --hidden'
              '';
            };
            mkdcd = {
              description = "Make a directory tree and enter it";
              body = "mkdir -p $argv[1]; and cd $argv[1]";
            };
          };
        };
      };
    };

  flake.modules.darwin.fish.programs.fish.enable = true;
}

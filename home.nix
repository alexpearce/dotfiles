{ config, pkgs, ... }:

{

  home = {
    username = "apearce";
    homeDirectory = "/Users/apearce";
    # Specify packages not explicitly configured below
    packages = with pkgs; [
      entr
      fd
      httpie
      hyperfine
      imagemagick
      jq
      neovim
      nodejs
      pandoc
      ripgrep
      tree
      tree-sitter
      youtube-dl
    ];
    sessionVariables = {
      EDITOR = "nvim";
    };
    stateVersion = "21.11";
  };

  programs = {
    bat = {
      enable = true;
      config = {
        theme = "GitHub";
        italic-text = "always";
      };
    };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };

    exa = {
      enable = true;
      enableAliases = true;
    };

    fish = {
      enable = true;
      plugins = [
        {
          name = "iterm2-shell-integration";
          src = ./config/fish/iterm2_shell_integration;
        }
        {
          name = "fzf";
          src = pkgs.fetchFromGitHub {
            owner = "PatrickF1";
            repo = "fzf.fish";
            rev = "6d8e962f3ed84e42583cec1ec4861d4f0e6c4eb3";
            sha256 = "sha256-0rnd8oJzLw8x/U7OLqoOMQpK81gRc7DTxZRSHxN9YlM";
          };
        }
        {
          name = "fish-kubectl-completions";
          src = pkgs.fetchFromGitHub {
            owner = "evanlucas";
            repo = "fish-kubectl-completions";
            rev = "ced676392575d618d8b80b3895cdc3159be3f628";
            sha256 = "sha256-OYiYTW+g71vD9NWOcX1i2/TaQfAg+c2dJZ5ohwWSDCc";
          };
        }
        # Need this when using Fish as a default macOS shell in order to pick
        # up ~/.nix-profile/bin
        {
          name = "nix-env";
          src = pkgs.fetchFromGitHub {
            owner = "lilyball";
            repo = "nix-env.fish";
            rev = "00c6cc762427efe08ac0bd0d1b1d12048d3ca727";
            sha256 = "1hrl22dd0aaszdanhvddvqz3aq40jp9zi2zn0v1hjnf7fx4bgpma";
          };
        }
      ];
      shellInit = ''
        # Set syntax highlighting colours; var names defined here:
        # http://fishshell.com/docs/current/index.html#variables-color
        set fish_color_normal normal
        set fish_color_command white
        set fish_color_quote brgreen
        set fish_color_redirection brblue
        set fish_color_end white
        set fish_color_error -o brred
        set fish_color_param brpurple
        set fish_color_comment --italics brblack
        set fish_color_match cyan
        set fish_color_search_match --background=brblack
        set fish_color_operator cyan
        set fish_color_escape white
        set fish_color_autosuggestion brblack
      '';
      interactiveShellInit = ''
        # Activate the iTerm 2 shell integration
        iterm2_shell_integration

        # Pick up conda installation
        if test -x /Users/apearce/.mambaforge/bin/conda
          eval /Users/apearce/.mambaforge/bin/conda "shell.fish" "hook" $argv | source
        end
      '';
      shellAliases = {
        ipython = "ipython --no-banner";
        nvim = "nvim -p";
        vim = "vim -p";
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
        ip = "ipython";
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
        gpf = "git push -f";
        gpl = "git pull";
        gplp = "git pull --prune";
        gr = "git restore";
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
        h = "http";
        hme = "home-manager edit";
        hms = "home-manager switch";
        k = "kubectl";
        ka = "kubectl apply -f";
        kcgc = "kubectl config get-contexts";
        kcuc = "kubectl config use-context";
        kd = "kubectl describe";
        kg = "kubectl get";
        kl = "kubectl logs";
        kr = "kubectl run -i --tty";
        m = "make";
        n = "nvim";
        o = "open";
        p = "python3";
      };
      functions = {
        ctrlp = {
          description = "Launch Neovim file finder from the shell";
          argumentNames = "hidden";
          body = ''
            if test -n "$hidden"
              nvim -c 'lua require(\'telescope.builtin\').find_files({hidden = true})'
            else
              nvim -c 'lua require(\'telescope.builtin\').find_files()'
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
        nvimrg = {
          description = "Open files matched by ripgrep with Neovim";
          body = "nvim (rg -l $argv) +/\"$argv[-1]\"";
        };
      };
    };

    fzf = {
      enable = true;
      enableFishIntegration = false;
    };

    gh = {
      enable = true;
      settings = {
        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
        git_protocol = "ssh";
      };
    };

    git = {
      enable = true;
      userName = "Alex Pearce";
      userEmail = "alex@alexpearce.me";
      aliases = {
        prettylog = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      };
      delta = {
        enable = true;
        options = {
          navigate = true;
          line-numbers = true;
          syntax-theme = "GitHub";
        };
      };
      extraConfig = {
        core = {
          editor = "nvim";
          # If git uses `ssh` from Nix the macOS-specific configuration in
          # `~/.ssh/config` won't be seen as valid
          # https://github.com/NixOS/nixpkgs/issues/15686#issuecomment-865928923
          sshCommand = "/usr/bin/ssh";
        };
        color = {
          ui = true;
        };
        push = {
          default = "current";
        };
        pull = {
          ff = "only";
        };
        init = {
          defaultBranch = "main";
        };
        # Clone git repos with URLs like "gh:alexpearce/dotfiles"
        url."git@github.com:" = {
          insteadOf = "gh:";
          pushInsteadOf = "gh:";
        };
      };
      ignores = [
        ".*.swp"
        ".bundle"
        "vendor/bundle"
        ".DS_Store"
        "Icon"
        "*.pyc"
        ".envrc"
        "environment.yaml"
      ];
    };

    helix = {
      enable = true;
      settings = {
        theme = "onedark";
        editor.lsp.display-messages = true;
        keys.normal = {
          space.space = "file_picker";
          space.w = ":w";
          space.q = ":q";
          space.x = ":x";
        };
      };
    };

    home-manager.enable = true;

    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = true;
      };
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';

  # FIXME The init.vim unconditionally installed by this module conflicts with
  # our init.lua, so we cannot use the module for now and must install the
  # configuration explicitly
  xdg.configFile.nvim = {
    source = ./config/neovim;
    recursive = true;
  };
}

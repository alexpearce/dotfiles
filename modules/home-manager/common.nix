{
  config,
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
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

    sessionVariables = {
      EDITOR = "hx";
    };
  };

  programs = {
    bat = {
      enable = true;
      config = {
        theme = "base16";
        italic-text = "always";
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        navigate = true;
        line-numbers = true;
      };
    };

    direnv = {
      enable = true;
      config = {
        global.hide_env_diff = true;
      };
      nix-direnv = {
        enable = true;
      };
    };

    eza = {
      enable = true;
    };

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

    ghostty = {
      enable = true;
      settings = {
        theme = "TokyoNight Moon";
        command = "${config.home.profileDirectory}/bin/fish";
        # Move between panes with cmd+opt+{h,j,k,l}.
        keybind = [
          "cmd+opt+h=goto_split:left"
          "cmd+opt+j=goto_split:bottom"
          "cmd+opt+k=goto_split:top"
          "cmd+opt+l=goto_split:right"
          # Close the current surface with cmd+shift+w.
          "global:cmd+shift+w=close_surface"
        ];
        font-family = "Iosevka Term";
        font-feature = "+dlig";
        font-style = "Medium";
        font-style-bold = "Bold";
        font-style-italic = "Medium Italic";
        font-style-bold-italic = "Bold Italic";
        font-size = 16;
        # 256 MiB.
        scrollback-limit = 268435456;
      };
    };

    git = {
      enable = true;
      settings = {
        alias = {
          prettylog = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
        };
        core = {
          # If git uses `ssh` from Nix the macOS-specific configuration in
          # `~/.ssh/config` won't be seen as valid
          # https://github.com/NixOS/nixpkgs/issues/15686#issuecomment-865928923
          sshCommand = "/usr/bin/ssh";
        };
        color = {
          ui = true;
        };
        diff = {
          colorMoved = "default";
        };
        merge = {
          conflictstyle = "zdiff3";
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
        user.email = "alex@pearwin.com";
        user.name = "Alex Pearwin";
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
        ".direnv"
      ];
    };

    helix = {
      enable = true;
      settings = {
        theme = "tokyonight_moon";
        editor = {
          bufferline = "multiple";
          color-modes = true;
          line-number = "relative";
          lsp.display-messages = true;
        };
        keys.normal = {
          space.w = ":w";
          space.q = ":q";
          space.x = ":x";
        };
      };
      languages.language = [
        {
          name = "elixir";
          auto-format = true;
        }
      ];
    };

    home-manager.enable = true;

    starship = {
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

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}

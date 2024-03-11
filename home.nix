{
  config,
  pkgs,
  ...
}: {
  home = {
    # Specify packages not explicitly configured below
    packages = with pkgs; [
      colima
      docker
      entr
      fd
      httpie
      hyperfine
      imagemagick
      jq
      nodejs
      pandoc
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

    eza = {
      enable = true;
      enableAliases = true;
    };

    fish = {
      enable = true;
      plugins = [
        {
          name = "fzf";
          src = pkgs.fetchFromGitHub {
            owner = "PatrickF1";
            repo = "fzf.fish";
            rev = "6d8e962f3ed84e42583cec1ec4861d4f0e6c4eb3";
            sha256 = "sha256-0rnd8oJzLw8x/U7OLqoOMQpK81gRc7DTxZRSHxN9YlM";
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
      # Send OSC 133 escape sequences to signal prompt and ouput start and end.
      interactiveShellInit = ''
        function terminal_integration_preprompt --on-event fish_prompt
          printf "\033]133;A;\007"
        end

        # TODO not used yet.
        function terminal_integration_postprompt
          printf "\033]133;B;\007"
        end

        function terminal_integration_preexec --on-event fish_preexec
          printf "\033]133;C;\007"
        end

        function terminal_integration_postexec --on-event fish_postexec
          printf "\033]133;D;\007"
        end
      '';
      shellAliases = {
        ipython = "ipython --no-banner";
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
        hme = "home-manager --flake ~/Code/dotfiles edit";
        hms = "home-manager --flake ~/Code/dotfiles switch";
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

    git = {
      enable = true;
      userName = "Alex Pearwin";
      userEmail = "alex@pearwin.com";
      aliases = {
        prettylog = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      };
      delta = {
        enable = true;
        # Custom `delta` executable whichs sets light/dark feature
        # depending on OS appearance.
        package = pkgs.writeShellApplication {
          name = "delta";
          runtimeInputs = [pkgs.delta];
          text = ''
            features=$(defaults read -globalDomain AppleInterfaceStyle > /dev/null 2>&1 && printf dark-mode || printf light-mode)
            env DELTA_FEATURES="$features" ${pkgs.delta}/bin/delta "$@"
          '';
        };
        options = {
          light-mode = {
            light = true;
            syntax-theme = "GitHub";
          };
          dark-mode = {
            dark = true;
            syntax-theme = "OneHalfDark";
          };
          features = "light-mode";
          navigate = true;
          line-numbers = true;
        };
      };
      extraConfig = {
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
      includes = [
        {
          contents = {
            commit = {
              gpgsign = true;
            };
            gpg = {
              format = "ssh";
            };
            user = {
              email = "alex.pearwin@multiverse.io";
              signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINDfqmONBNsg0/E8VBzLiIpf5aP+pQIl++DAHtPYY2Dz";
            };
          };
          condition = "gitdir:~/Multiverse/";
        }
      ];
    };

    helix = {
      enable = true;
      settings = {
        theme = "onelight";
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
      };
    };

    wezterm = {
      enable = true;
      extraConfig = ''
        -- https://wezfurlong.org/wezterm/config/lua/window/get_appearance.html
        function color_scheme_for_appearance(appearance)
          if appearance:find 'Dark' then
            return 'OneDark (base16)'
          else
            return 'One Light (base16)'
          end
        end

        wezterm.on('window-config-reloaded', function(window, pane)
          local overrides = window:get_config_overrides() or {}
          local appearance = window:get_appearance()
          local color_scheme = color_scheme_for_appearance(appearance)
          if overrides.color_scheme ~= color_scheme then
            overrides.color_scheme = color_scheme
            window:set_config_overrides(overrides)
          end
        end)

        return {
          bold_brightens_ansi_colors = "BrightAndBold",
          color_scheme = "One Light (base16)",
          default_prog = { "/Users/${config.home.username}/.nix-profile/bin/fish" },
          font = wezterm.font("JetBrains Mono"),
          font_size = 14.0,
          keys = {
            -- Close panes with shift+w.
            {
              key = "w",
              mods = "CMD|SHIFT",
              action = wezterm.action.CloseCurrentPane { confirm = true },
            },
            -- Vim-style hjkl navigation between panes.
            {
              key = "h",
              mods = "CMD|OPT",
              action = wezterm.action.ActivatePaneDirection("Left"),
            },
            {
              key = "j",
              mods = "CMD|OPT",
              action = wezterm.action.ActivatePaneDirection("Down"),
            },
            {
              key = "k",
              mods = "CMD|OPT",
              action = wezterm.action.ActivatePaneDirection("Up"),
            },
            {
              key = "l",
              mods = "CMD|OPT",
              action = wezterm.action.ActivatePaneDirection("Right"),
            },
            -- iTerm-style cmd-d/cmd-shift-d pane splitting.
            {
              key = "d",
              mods = "CMD",
              action = wezterm.action.SplitPane({direction = "Right"})
            },
            {
              key = "d",
              mods = "CMD|SHIFT",
              action = wezterm.action.SplitPane({direction = "Down"})
            },
            -- iTerm-style cmd-shift-enter pane zoom toggle.
            {
              key = "Enter",
              mods = "CMD|SHIFT",
              action = wezterm.action.TogglePaneZoomState,
            },
            -- Scroll between prompts.
            {
              key = "UpArrow",
              mods = "CMD|SHIFT",
              action = wezterm.action.ScrollToPrompt(-1),
            },
            {
              key = "DownArrow",
              mods = "CMD|SHIFT",
              action = wezterm.action.ScrollToPrompt(1),
            },
            -- Type a hash symbol.
            {
              key = "3",
              mods = "OPT",
              action = wezterm.action.SendString("#"),
            },
          },
          hide_tab_bar_if_only_one_tab = true,
          mouse_bindings = {
            {
              event = { Down = { streak = 3, button = 'Left' } },
              action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
              mods = 'NONE',
            },
          },
          use_fancy_tab_bar = true,
        }
      '';
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';
}

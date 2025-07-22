{ config, pkgs, lib, ... }:

let name = "Tomasz Wostal";
    user = "twostal";
    email = "tomasz.wostal@hemolens.com"; in
{
  # Shared shell configuration
  zsh = {
    enable = true;
    autocd = false;
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
      ];
    };

    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH
      export PATH=$HOME/.local/bin:$PATH
      export PATH=$HOME/.cargo/bin:$PATH
      export PATH=$HOME/.local/share/nvim/bin:$PATH
      export PATH=/run/current-system/sw/bin:$PATH
      export PATH=/opt/homebrew/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # Emacs is my editor
      export ALTERNATE_EDITOR=""
      export EDITOR="nvim"
      export VISUAL="nvim"

      e() {
          emacsclient -t "$@"
      }

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'

      # comletion
      zmodload zsh/complist
      autoload -Uz compinit && compinit
      zstyle ':completion:*' menu select
      
      # carapace
      export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
      zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
      zstyle ':completion:*:git:*' group-order 'main commands' 'alias commands' 'external commands'
      source <(carapace _carapace)
    '';
  };

  carapace = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = false;
    enableZshIntegration = true;
  };

  starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = "$directory$character";
      palette = "catppuccin_macchiato";
      right_format = "$all";
      command_timeout = 1000;

      character = {
        vicmd_symbol = "[N] >>>";
        success_symbol = "[➜](bold green)";
      };

      directory = {
        substitutions = {
        "~/tests/starship-custom" = "work-project";
        };
      };

      git_branch = {
        format =  "[$symbol$branch(:$remote_branch)]($style)";
      };

      golang = {
        format = "[ ](bold cyan)";
      };

      kubernetes = {
        symbol = "☸ ";
        disabled = false;
      };

      docker_context = {
        disabled = false;
      };

      palettes = {
        catppuccin_macchiato = {
          rosewater = "#f4dbd6";
          flamingo = "#f0c6c6";
          pink = "#f5bde6";
          mauve = "#c6a0f6";
          red = "#ed8796";
          maroon = "#ee99a0";
          peach = "#f5a97f";
          yellow = "#eed49f";
          green = "#a6da95";
          teal = "#8bd5ca";
          sky = "#91d7e3";
          sapphire = "#7dc4e4";
          blue = "#8aadf4";
          lavender = "#b7bdf8";
          text = "#cad3f5";
          subtext1 = "#b8c0e0";
          subtext0 = "#a5adcb";
          overlay2 = "#939ab7";
          overlay1 = "#8087a2";
          overlay0 = "#6e738d";
          surface2 = "#5b6078";
          surface1 = "#494d64";
          surface0 = "#363a4f";
          base = "#24273a";
          mantle = "#1e2030";
          crust = "#181926";
        };
      };
    };
  };

  atuin = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    flags = [
      "--disable-up-arrow"
    ];
    settings = {
      theme = {
        name = "catppuccin-mocha-roserwater";
      };
      style = "compact";
      enter_accept = "true";

      sync = {
        records = "true";
      };
    };
  };

  k9s = {
    enable = true;
    settings = {
      theme = "catppuccin-macchiato";
      config = {
        k9s = {
          refreshRate = "2s";
          logLevel = "info";
        };
      };
    };
    skins = {
      catppuccin-macchiato = {
        k9s = {
          body = {
            fgColor   = "#cad3f5";
            bgColor   = "#24273a";
            logoColor = "#c6a0f6";
          };
          prompt = {
            fgColor      = "#cad3f5";
            bgColor      = "#1e2030";
            suggestColor = "#8aadf4";
          };
          help = {
            fgColor      = "#cad3f5";
            bgColor      = "#24273a";
            sectionColor = "#a6da95";
            keyColor     = "#8aadf4";
            numKeyColor  = "#ee99a0";
          };
          frame = {
            title = {
              fgColor        = "#8bd5ca";
              bgColor        = "#24273a";
              highlightColor = "#f5bde6";
              counterColor   = "#eed49f";
              filterColor    = "#a6da95";
            };
            border = {
              fgColor    = "#c6a0f6";
              focusColor = "#b7bdf8";
            };
            menu = {
              fgColor     = "#cad3f5";
              keyColor    = "#8aadf4";
              numKeyColor = "#ee99a0";
            };
            crumbs = {
              fgColor     = "#24273a";
              bgColor     = "#ee99a0";
              activeColor = "#f0c6c6";
            };
            status = {
              newColor       = "#8aadf4";
              modifyColor    = "#b7bdf8";
              addColor       = "#a6da95";
              pendingColor   = "#f5a97f";
              errorColor     = "#ed8796";
              highlightColor = "#91d7e3";
              killColor      = "#c6a0f6";
              completedColor = "#6e738d";
            };
          };
          info = {
            fgColor      = "#f5a97f";
            sectionColor = "#cad3f5";
          };
          views = {
            table = {
              fgColor         = "#cad3f5";
              bgColor         = "#24273a";
              cursorFgColor   = "#363a4f";
              cursorBgColor   = "#494d64";
              markColor       = "#f4dbd6";
              header = {
                fgColor     = "#eed49f";
                bgColor     = "#24273a";
                sorterColor = "#91d7e3";
              };
            };
            xray = {
              fgColor        = "#cad3f5";
              bgColor        = "#24273a";
              cursorColor    = "#494d64";
              cursorTextColor = "#24273a";
              graphicColor   = "#f5bde6";
            };
            charts = {
              bgColor            = "#24273a";
              chartBgColor       = "#24273a";
              dialBgColor        = "#24273a";
              defaultDialColors  = [ "#a6da95" "#ed8796" ];
              defaultChartColors = [ "#a6da95" "#ed8796" ];
              resourceColors = {
                cpu = [ "#c6a0f6" "#8aadf4" ];
                mem = [ "#eed49f" "#f5a97f" ];
              };
            };
            yaml = {
              keyColor   = "#8aadf4";
              valueColor = "#cad3f5";
              colonColor = "#a5adcb";
            };
            logs = {
              fgColor = "#cad3f5";
              bgColor = "#24273a";
              indicator = {
                fgColor         = "#b7bdf8";
                bgColor         = "#24273a";
                toggleOnColor   = "#a6da95";
                toggleOffColor  = "#a5adcb";
              };
            };
          };
          dialog = {
            fgColor            = "#eed49f";
            bgColor            = "#939ab7";
            buttonFgColor      = "#24273a";
            buttonBgColor      = "#8087a2";
            buttonFocusFgColor = "#24273a";
            buttonFocusBgColor = "#f5bde6";
            labelFgColor       = "#f4dbd6";
            fieldFgColor       = "#cad3f5";
          };
         };
      };
    };
  };
  
  ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    enableZshIntegration = true;
    enableBashIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    settings = {
      theme = "catppuccin-macchiato";
      font-size = 14;
    };
  };

  git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
	    editor = "vim";
        autocrlf = "input";
      };
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };

  alacritty = {
    enable = false;
    settings = {
      cursor = {
        style = "Block";
      };

      window = {
        opacity = 1.0;
        padding = {
          x = 24;
          y = 24;
        };
      };

      font = {
        normal = {
          family = "MesloLGS NF";
          style = "Regular";
        };
        size = lib.mkMerge [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux 10)
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin 14)
        ];
      };

      dynamic_padding = true;
      decorations = "full";
      title = "Terminal";
      class = {
        instance = "Alacritty";
        general = "Alacritty";
      };

      colors = {
        primary = {
          background = "0x1f2528";
          foreground = "0xc0c5ce";
        };

        normal = {
          black = "0x1f2528";
          red = "0xec5f67";
          green = "0x99c794";
          yellow = "0xfac863";
          blue = "0x6699cc";
          magenta = "0xc594c5";
          cyan = "0x5fb3b3";
          white = "0xc0c5ce";
        };

        bright = {
          black = "0x65737e";
          red = "0xec5f67";
          green = "0x99c794";
          yellow = "0xfac863";
          blue = "0x6699cc";
          magenta = "0xc594c5";
          cyan = "0x5fb3b3";
          white = "0xd8dee9";
        };
      };
    };
  };

  ssh = {
    enable = false;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "/home/${user}/.ssh/tomasz.wostal@hemolens.eu"
          )
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "/Users/${user}/.ssh/tomasz.wostal@hemolens.eu"
          )
        ];
      };
    };
  };

  tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = with pkgs; [
      pkgs.tmuxPlugins.continuum
      pkgs.tmuxPlugins.sensible
      pkgs.tmuxPlugins.yank
      pkgs.tmuxPlugins.tmux-thumbs
      pkgs.tmuxPlugins.tmux-fzf
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.tmux-floax;
        extraConfig = ''
          set -g @floax-width '80%'
          set -g @floax-height '80%'
          set -g @floax-border-color 'magenta'
          set -g @floax-text-color 'blue'
          set -g @floax-bind 'p'
          set -g @floax-change-path 'true'
        '';
      }
      {
        plugin = tmuxPlugins.tmux-sessionx;
        extraConfig = ''
          set -g @sessionx-bind-zo-new-window 'ctrl-y'
          set -g @sessionx-auto-accept 'off'
          set -g @sessionx-custom-paths '~/.dotfiles'
          set -g @sessionx-bind 'o'
          set -g @sessionx-x-path '~/.dotfiles'
          set -g @sessionx-window-height '85%'
          set -g @sessionx-window-width '75%'
          set -g @sessionx-zoxide-mode 'on'
          set -g @sessionx-custom-paths-subdirectories 'false'
          set -g @sessionx-filter-current 'false'
        '';
      }
      {
        plugin = tmuxPlugins.catppuccin.overrideAttrs ( _: {
          src = pkgs.fetchFromGitHub {
            owner = "omerxx";
            repo = "catppuccin-tmux";
            rev = "e30336b79986e87b1f99e6bd9ec83cffd1da2017";
            sha256 = "sha256-Ig6+pB8us6YSMHwSRU3sLr9sK+L7kbx2kgxzgmpR920=";
          };
        });
        extraConfig = ''
          set -g @catppuccin_flavour 'macchiato'
          set -g @catppuccin_window_status_style "rounded"
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
          set -g @catppuccin_status_modules_right "directory meetings date_time"
          set -g @catppuccin_status_modules_left "session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator " "
          set -g @catppuccin_status_right_separator_inverse "no"
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"
          set -g @catppuccin_directory_text "#{b:pane_current_path}"
          set -g @catppuccin_meetings_text "#($HOME/.config/tmux/scripts/cal.sh)"
          set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M"
        '';
      }
      {
        plugin = tmuxPlugins.fzf-tmux-url;
        extraConfig = ''
          set -g @fzf-url-fzf-options '-p 60%,30% --prompt="   " --border-label=" Open URL "'
          set -g @fzf-url-history-limit '2000'
        '';
      }
    ];
    extraConfig = ''
      bind ^X lock-server
      set -g lock-after-time 300
      set -g lock-command "unimatrix -a -c=blue -f"
      bind ^C new-window -c "$HOME"
      bind ^D detach
      bind * list-clients

      bind H previous-window
      bind L next-window

      bind r command-prompt "rename-window %%"
      bind R source-file ~/.config/tmux/tmux.conf
      bind ^A last-window
      bind ^W list-windows
      bind w list-windows
      bind z resize-pane -Z
      bind ^L refresh-client
      bind l refresh-client
      bind | split-window
      bind s split-window -v -c "#{pane_current_path}"
      bind v split-window -h -c "#{pane_current_path}"
      bind '"' choose-window
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      bind -r -T prefix , resize-pane -L 20
      bind -r -T prefix . resize-pane -R 20
      bind -r -T prefix - resize-pane -D 7
      bind -r -T prefix = resize-pane -U 7
      bind : command-prompt
      bind * setw synchronize-panes
      bind P set pane-border-status
      bind c kill-pane
      bind x swap-pane -D
      bind S choose-session
      bind R source-file ~/.config/tmux/tmux.conf
      bind K send-keys "clear"\; send-keys "Enter"
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      set-option -g default-terminal 'screen-256color'
      set-option -g terminal-overrides ',xterm-256color:RGB'
      set -g prefix ^A
      set -g base-index 1              # start indexing windows at 1 instead of 0
      set -g detach-on-destroy off     # don't exit from tmux when closing a session
      set -g escape-time 0             # zero-out escape time delay
      set -g history-limit 1000000     # increase history size (from 2,000)
      set -g renumber-windows on       # renumber all windows when any window is closed
      set -g set-clipboard on          # use system clipboard
      set -g status-position top       # macOS / darwin style
      setw -g mode-keys vi
      set -g pane-active-border-style 'fg=magenta,bg=default'
      set -g pane-border-style 'fg=brightblack,bg=default'
      set -g default-command ${pkgs.zsh}/bin/zsh
    '';
  };

  lazygit = {
    enable = true;
    settings = {
      theme = "catppuccin-macchiato";
      config = {
        lazygit = {
          colors = {
            primary = "#24273a";
            secondary = "#363a4f";
            tertiary = "#494d64";
            text = "#cad3f5";
            textDimmed = "#939ab7";
            textBold = "#c6a0f6";
            textError = "#ed8796";
            textWarning = "#f5a97f";
            textSuccess = "#a6da95";
          };
        };
      };
    };
  };

  lazydocker = {
    enable = true;
  };

  neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };

  zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  bat = {
    enable = true;
    config = {
      theme = "catppuccin-macchiato";
    };
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      prettybat
    ];
  };

  go = {
    enable = true;
  };

  qutebrowser = {
    enable = false;
  };
  
  firefox = {
    enable = true;
  };

  vscode = {
    enable = true;
  };
}

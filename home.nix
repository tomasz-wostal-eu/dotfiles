{ config, pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "twostal";
  home.homeDirectory = "/home/twostal";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    neofetch
    nnn # terminal file manager
    obsidian

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    fd
    gcalcli

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    mc
    bat
    zoxide
    tmux
    ascii-image-converter
    bitwarden
    doctl
    google-cloud-sdk
    awscli
    azure-cli
    kubeseal
    upbound
    kuttl
    cloudflared
    xsel

    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    nfs-utils
    xclip

    # dev tools
    automake
    cargo
    cmake
    clang
    gnumake
    yarn
    python3
    pipx
    pipenv
    poetry
    lua
    nixd
    nil
    dotnet-sdk
    #dotnet-runtime
    nodejs
    lua-language-server
    ansible-language-server
    angular-language-server
    arduino-language-server
    arduino-cli
    autotools-language-server
    #awk-language-server
    basedpyright
    bash-language-server
    cmake-language-server
    csharp-ls
    docker-compose-language-service
    dockerfile-language-server-nodejs
    vscode-langservers-extracted
    golangci-lint
    golangci-lint-langserver
    gopls
    helm-ls
    jq-lsp
    jsonnet-language-server
    postgres-lsp
    pyright
    rust-analyzer
    terraform
    terraform-ls
    terraform-lsp
    tflint
    typescript-language-server
    vim-language-server
    yaml-language-server
    luarocks-nix
    tree-sitter
    kind
    kubernetes-helm
    k9s
    argocd
    just
    envsubst
    kubectl
    lazygit
    openssl
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Tomasz Wostal";
    userEmail = "tomasz@wostal.eu";
    extraConfig = {
      safe.directory = "*";
    };
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Copy dotfiles
  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/twostal/.dotfiles/nvim";
    };
    ".config/atuin" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/twostal/.dotfiles/atuin/";
    };
  };

  # nushell
  programs.nushell = {
    enable = true;
    # configFile.source = ./nushell/config.nu;
    # envFile.source = ./nushell/env.nu;
    extraConfig = ''
       let carapace_completer = {|spans: list<string>|
        carapace $spans.0 nushell ...$spans
        | from json
        | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
      }
       $env.config = {
        show_banner: false,
        completions: {
        case_sensitive: false # case-sensitive completions
        quick: true    # set to false to prevent auto-selecting completions
        partial: true    # set to false to prevent partial filling of the prompt
        algorithm: "fuzzy"    # prefix or fuzzy
        external: {
        # set to false to prevent nushell looking into $env.PATH to find more suggestions
            enable: true 
        # set to lower can improve completion performance at the cost of omitting some options
            max_results: 100 
            completer: $carapace_completer # check 'carapace_completer' 
          }
        }
       } 
       $env.PATH = ($env.PATH | 
       split row (char esep) |
       prepend /home/twostal/.apps |
       append /usr/bin/env |
       prepend /home/twostal/.cargo/bin |
       prepend /home/twostal/.npm-global/bin |
       prepend /home/twostal/go/bin
       )
       let theme = {
    rosewater: "#f4dbd6"
      flamingo: "#f0c6c6"
      pink: "#f5bde6"
      mauve: "#c6a0f6"
      red: "#ed8796"
      maroon: "#ee99a0"
      peach: "#f5a97f"
      yellow: "#eed49f"
      green: "#a6da95"
      teal: "#8bd5ca"
      sky: "#91d7e3"
      sapphire: "#7dc4e4"
      blue: "#8aadf4"
      lavender: "#b7bdf8"
      text: "#cad3f5"
      subtext1: "#b8c0e0"
      subtext0: "#a5adcb"
      overlay2: "#939ab7"
      overlay1: "#8087a2"
      overlay0: "#6e738d"
      surface2: "#5b6078"
      surface1: "#494d64"
      surface0: "#363a4f"
      base: "#24273a"
      mantle: "#1e2030"
      crust: "#181926"
    }

    let scheme = {
      recognized_command: $theme.blue
      unrecognized_command: $theme.text
      constant: $theme.peach
      punctuation: $theme.overlay2
      operator: $theme.sky
      string: $theme.green
      virtual_text: $theme.surface2
      variable: { fg: $theme.flamingo attr: i }
      filepath: $theme.yellow
    }

    $env.config.color_config = {
      separator: { fg: $theme.surface2 attr: b }
      leading_trailing_space_bg: { fg: $theme.lavender attr: u }
      header: { fg: $theme.text attr: b }
      row_index: $scheme.virtual_text
      record: $theme.text
      list: $theme.text
      hints: $scheme.virtual_text
      search_result: { fg: $theme.base bg: $theme.yellow }
      shape_closure: $theme.teal
    closure: $theme.teal
  shape_flag: { fg: $theme.maroon attr: i }
  shape_matching_brackets: { attr: u }
  shape_garbage: $theme.red
  shape_keyword: $theme.mauve
  shape_match_pattern: $theme.green
  shape_signature: $theme.teal
  shape_table: $scheme.punctuation
  cell-path: $scheme.punctuation
  shape_list: $scheme.punctuation
  shape_record: $scheme.punctuation
  shape_vardecl: $scheme.variable
  shape_variable: $scheme.variable
  empty: { attr: n }
  filesize: {||
    if $in < 1kb {
      $theme.teal
    } else if $in < 10kb {
      $theme.green
    } else if $in < 100kb {
      $theme.yellow
    } else if $in < 10mb {
      $theme.peach
    } else if $in < 100mb {
      $theme.maroon
    } else if $in < 1gb {
      $theme.red
    } else {
      $theme.mauve
    }
  }
  duration: {||
    if $in < 1day {
      $theme.teal
    } else if $in < 1wk {
      $theme.green
    } else if $in < 4wk {
      $theme.yellow
    } else if $in < 12wk {
      $theme.peach
    } else if $in < 24wk {
      $theme.maroon
    } else if $in < 52wk {
      $theme.red
    } else {
      $theme.mauve
    }
  }
  date: {|| (date now) - $in |
    if $in < 1day {
      $theme.teal
    } else if $in < 1wk {
      $theme.green
    } else if $in < 4wk {
      $theme.yellow
    } else if $in < 12wk {
      $theme.peach
    } else if $in < 24wk {
      $theme.maroon
    } else if $in < 52wk {
      $theme.red
    } else {
      $theme.mauve
    }
  }
  shape_external: $scheme.unrecognized_command
  shape_internalcall: $scheme.recognized_command
  shape_external_resolved: $scheme.recognized_command
  shape_block: $scheme.recognized_command
  block: $scheme.recognized_command
  shape_custom: $theme.pink
  custom: $theme.pink
  background: $theme.base
  foreground: $theme.text
  cursor: { bg: $theme.rosewater fg: $theme.base }
  shape_range: $scheme.operator
  range: $scheme.operator
  shape_pipe: $scheme.operator
  shape_operator: $scheme.operator
  shape_redirection: $scheme.operator
  glob: $scheme.filepath
  shape_directory: $scheme.filepath
  shape_filepath: $scheme.filepath
  shape_glob_interpolation: $scheme.filepath
  shape_globpattern: $scheme.filepath
  shape_int: $scheme.constant
  int: $scheme.constant
  bool: $scheme.constant
  float: $scheme.constant
  nothing: $scheme.constant
  binary: $scheme.constant
  shape_nothing: $scheme.constant
  shape_bool: $scheme.constant
  shape_float: $scheme.constant
  shape_binary: $scheme.constant
  shape_datetime: $scheme.constant
  shape_literal: $scheme.constant
  string: $scheme.string
  shape_string: $scheme.string
  shape_string_interpolation: $theme.flamingo
  shape_raw_string: $scheme.string
  shape_externalarg: $scheme.string
}
$env.config.highlight_resolved_externals = true
$env.config.explore = {
    status_bar_background: { fg: $theme.text, bg: $theme.mantle },
    command_bar_text: { fg: $theme.text },
    highlight: { fg: $theme.base, bg: $theme.yellow },
    status: {
        error: $theme.red,
        warn: $theme.yellow,
        info: $theme.blue,
    },
    selected_cell: { bg: $theme.blue fg: $theme.base },
}
       '';
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.fzf = {
    enable = true;
  };

  programs.go = {
    enable = true;
    goBin = "go/bin";
    goPath = "go";
  };

  # neovim
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };

  programs.ghostty = {
    enable = true;
    settings = {
      theme = "catppuccin-macchiato";
      font-size = 10;
    };
  };

  programs.atuin = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      bind ^X lock-server
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
      set-option -g default-terminal "screen-256color"
      set-option -g terminal-overrides ",xterm-256color:RGB"

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

      set -g @fzf-url-fzf-options '-p 60%,30% --prompt="   " --border-label=" Open URL "'
      set -g @fzf-url-history-limit '2000'

      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'tmux-plugins/tmux-yank'
      set -g @plugin 'tmux-plugins/tmux-resurrect'
      set -g @plugin 'tmux-plugins/tmux-continuum'
      set -g @plugin 'fcsonline/tmux-thumbs'
      set -g @plugin 'sainnhe/tmux-fzf'
      set -g @plugin 'wfxr/tmux-fzf-url'
      set -g @plugin 'omerxx/catppuccin-tmux' # My fork that holds the meetings script bc I'm lazy af
      set -g @plugin 'omerxx/tmux-sessionx'
      set -g @plugin 'omerxx/tmux-floax'
      set -g @floax-width '80%'
      set -g @floax-height '80%'
      set -g @floax-border-color 'magenta'
      set -g @floax-text-color 'blue'
      set -g @floax-bind 'p'
      set -g @floax-change-path 'false'
      set -g @sessionx-auto-accept 'off'
      set -g @sessionx-custom-paths '~/.dotfiles/'
      set -g @sessionx-bind 'o'
      set -g @sessionx-x-path '~/.dotfiles'
      set -g @sessionx-window-height '85%'
      set -g @sessionx-window-width '75%'
      set -g @sessionx-zoxide-mode 'on'
      set -g @sessionx-custom-paths-subdirectories 'false'
      set -g @sessionx-filter-current 'false'
      set -g @continuum-restore 'on'
      set -g @resurrect-strategy-nvim 'session'
      set -g @catppuccin_window_left_separator ""
      set -g @catppuccin_window_right_separator " "
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
      set -g @catppuccin_date_time_text "%H:%M"
      set -g @catppuccin_flavour 'macchiato'

      run '~/.tmux/plugins/tpm/tpm'
    '';
  };
}

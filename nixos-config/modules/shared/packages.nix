{ pkgs }:

with pkgs; [
  # General packages for development and system management
  alacritty
  aspell
  aspellDicts.en
  aspellDicts.pl
  bash-completion
  btop
  coreutils
  killall
  neofetch
  openssh
  sqlite
  wget
  zip

  # Encryption and security tools
  age
  age-plugin-yubikey
  gnupg
  libfido2

  # Cloud-related tools and SDKs
  docker
  docker-compose

  # Media-related packages
  emacs-all-the-icons-fonts
  dejavu_fonts
  ffmpeg
  fd
  font-awesome
  hack-font
  noto-fonts
  noto-fonts-emoji
  meslo-lgs-nf

  # Node.js development tools
  nodePackages.npm # globally install npm
  nodePackages.prettier
  nodejs
  fnm

  # Text and terminal utilities
  htop
  hunspell
  iftop
  jetbrains-mono
  jq
  ripgrep
  tree
  tmux
  unrar
  unzip
  zsh-powerlevel10k
  fzf
  gnumake
  automake
  wget
  yq
  just
  ast-grep
  cmake
  cmake-language-server
  obsidian
  dbeaver-bin
  spotify
  claude-code


  # Python packages
  python3
  virtualenv

  # dotnet
  dotnet-sdk
  dotnet-runtime
  dotnet-aspnetcore

  # tests
  playwright-test

  # lua
  lua
  luarocks-packages-updater

  # rust
  rustup

  # julia
  julia-lts

  # php
  php
  composer-require-checker

  # java
  jdk
  
  # devops tools
  azure-cli
  azure-storage-azcopy
  offensive-azure
  terraform
  upbound
  ansible
  argo
  argo-rollouts
  argocd
  kargo
  doctl
  kubelogin
  kind
  cloud-provider-kind
  kubectx
  kubernetes-helm
  yamllint
  lens
  k8sgpt

  # browsers
  brave
  google-chrome

  # eye candy
  cpufetch
  nerdfetch
  fastfetch
  cmatrix
  unimatrix
  libpng
  zig
]

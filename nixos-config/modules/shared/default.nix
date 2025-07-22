{ config, pkgs, ... }:

let
  emacsOverlaySha256 = "06413w510jmld20i4lik9b36cfafm501864yq8k4vxl5r4hn0j0h";
in
{
  imports = [
    ./nvim/default.nix
    ./nvim/assistant.nix
    ./nvim/autocomplete.nix
    ./nvim/autopairs.nix
    ./nvim/avante.nix
    ./nvim/binds.nix
    ./nvim/clipboard.nix
    ./nvim/comments.nix
    ./nvim/dashboard.nix
    ./nvim/dressing.nix
    ./nvim/git.nix
    ./nvim/languages.nix
    ./nvim/mini.nix
    ./nvim/nui.nix
    ./nvim/options.nix
    ./nvim/plenary.nix
    ./nvim/settings.nix
    ./nvim/statusline.nix
    ./nvim/tabline.nix
    ./nvim/telescope.nix
    ./nvim/treesitter.nix
    ./nvim/ui.nix
    ./nvim/utility.nix
    ./nvim/visuals.nix
    ./nvim/theme.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowInsecure = false;
      allowUnsupportedSystem = true;
    };

    overlays =
      # Apply each overlay found in the /overlays directory
      let path = ../../overlays; in with builtins;
      map (n: import (path + ("/" + n)))
          (filter (n: match ".*\\.nix" n != null ||
                      pathExists (path + ("/" + n + "/default.nix")))
                  (attrNames (readDir path)))

      ++ [(import (builtins.fetchTarball {
               url = "https://github.com/dustinlyons/emacs-overlay/archive/refs/heads/master.tar.gz";
               sha256 = emacsOverlaySha256;
           }))];
  };
}

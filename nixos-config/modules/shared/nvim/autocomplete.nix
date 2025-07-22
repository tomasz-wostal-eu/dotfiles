{pkgs, ...}: {
  programs.nvf.settings.vim = {
    autocomplete = {
      enableSharedCmpSources = true;
      blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
      # sourcePlugins = {
      #   spell = {
      #     enable = true;
      #   };
      # };
      setupOpts = {
        sources = {
          default = [
            "copilot"
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
        };
      };
    };
  };
  };
}

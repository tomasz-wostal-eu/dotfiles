{pkgs, config, ...}: {
  programs.nvf.settings.vim = {
    assistant = {
      # TODO: avante
      copilot = {
        enable = true;
        cmp = {
          enable = true;
        };
      };
    };
  };
}

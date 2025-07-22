{
  programs.nvf.settings.vim = {
    git = {
      enable = true;
      git-conflict.enable = true;
      gitlinker-nvim.enable = true;
      gitsigns = {
        enable = true;
        codeActions.enable = true;
      };
      vim-fugitive = {
        enable = false;
      };
    };
  };
}

{pkgs, ...}: {
  programs.nvf.settings.vim.extraPlugins = {
    dressing-nvim = {
      package = pkgs.vimPlugins.dressing-nvim;
    };
  };
}

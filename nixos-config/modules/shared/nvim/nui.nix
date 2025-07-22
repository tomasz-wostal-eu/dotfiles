{pkgs, ...}: {
  programs.nvf.settings.vim.extraPlugins = {
    nui-nvim = {
      package = pkgs.vimPlugins.nui-nvim;
    };
  };
}

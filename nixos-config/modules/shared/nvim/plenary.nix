{pkgs, ...}: {
  programs.nvf.settings.vim.extraPlugins = {
    plenary-nvim = {
      package = pkgs.vimPlugins.plenary-nvim;  
    };
  };
}

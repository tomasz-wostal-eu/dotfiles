{pkgs, ...}: {
  programs.nvf.settings.vim = {
    package = pkgs.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    enableLuaLoader = true;
    syntaxHighlighting = true;
    preventJunkFiles = true;
    undoFile.enable = true;
    notify.nvim-notify.enable = true;
    presence.neocord.enable = true;
    projects.project-nvim.enable = true;
    globals.editorconfig = true;
  };
}

{
  programs.nvf.settings.vim = {
    mini = {
      diff = {
        enable = true;
      };
      pairs = {
        enable = true;
        setupOpts = {
          skip_unbalanced = true;
          markdown = true;
          skip_ts = [ "string" ];
        };
      };
      icons = {
        enable = true;
      };
    };
  };
}

{
  programs.nvf.settings.vim = {
    languages = {
      enableDAP = true;
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableLSP = true;
      enableTreesitter = true;

      bash = {
        enable = true;
        extraDiagnostics = {
          enable = true;
          types = [
            "shellcheck"
          ];
        };
        format = {
          enable = true;
          type = "shfmt";
        };
        lsp = {
          enable = true;
        };
        treesitter = {
          enable = true;
        };
      };

      csharp = {
        enable = true;
        lsp = {
          enable = true;
        };
        treesitter = {
          enable = true;
        };
      };

      go = {
        enable = true;
        dap = {
          enable = true;
          debugger = "delve";
        };
        format = {
          enable = true;
          type = "gofumpt";
        };
        lsp = {
          enable = true;
        };
        treesitter = {
          enable = true;
        };
      };

      # hcl = {
      #   enable = true;
      #   format = {
      #     enable = true;
      #   lsp = {
      #     enable = true;
      #   };
      #   treesitter = {
      #     enable = true;
      #   };
      # };

      helm = {
        enable = true;
        lsp = {
          enable = true;
        };
        treesitter = {
          enable = true;
        };
      };

      html = {
        enable = true;
        treesitter = {
          enable = true;
          autotagHtml = true;
        };
      };

      java = {
        enable = true;
        lsp = {
          enable = true;
        };
        treesitter = {
          enable = true;
        };
      };

      lua = {
        enable = true;
        extraDiagnostics = {
          enable = true;
          types = [
            "luacheck"
          ];
        };
        format = {
          enable = true;
          type = "stylua";
        };
        lsp = {
          enable = true;
          lazydev.enable = true;
        };
        treesitter = {
          enable = true;
        };
      };

      markdown = {
        enable = true;
        extensions = {
          markview-nvim.enable = true;
          render-markdown-nvim = {
            enable = true;
            setupOpts = {
              file_types = [
                "markdown"
                "Avante"
              ];
            };
          };
        };
        extraDiagnostics = {
          enable = true;
        };
        format = {
          enable = true;
        };
        lsp = {
          enable = true;
        };
        treesitter = {
          enable = true;
        };
      };

      nix = {
        enable = true;
        extraDiagnostics = {
          enable = true;
          types = [
            "deadnix"
            "statix"
          ];
        };
        format = {
          enable = true;
          type = "alejandra";
        };
        lsp = {
          enable = true;
        };
        treesitter = {
          enable = true;
        };
      };

      nu = {
        enable = true;
        lsp = {
          enable = true;
        };
        treesitter = {
          enable = true;
        };
      };

      python = {
        enable = true;
        dap = {
          enable = true;
          debugger = "debugpy";
        };
        format = {
          enable = true;
          type = "black";
        };
        lsp = {
          enable = true;
        };
        treesitter = {
          enable = true;
        };
      };

      rust = {
        enable = true;
        crates = {
          enable = true;
          codeActions = true;
        };
        dap = {
          enable = true;
        };
        format = {
          enable = true;
          type = "rustfmt";
        };
        lsp = {
          enable = true;
          opts = ''
            ['rust-analyzer'] = {
              cargo = {allFeature = true},
              checkOnSave = true,
              procMacro = {
                enable = true,
              },
            },
          '';
        };
      };

      sql = {
        enable = true;
        dialect = "ansi";
        extraDiagnostics = {
          enable = true;
          types = [
            "sqlfluff"
          ];
        };
        format = {
          enable = true;
          type = "sqlfluff";
        };
        lsp = {
          enable = true;
        };
        treesitter = {
          enable = true;
        };
      };

      terraform = {
        enable = true;
        lsp = {
          enable = true;
        };
        treesitter = {
          enable = true;
        };
      };

      ts = {
        enable = true;
        extensions = {
          ts-error-translator.enable = true;
        };
        extraDiagnostics = {
          enable = true;
          types = [
            "eslint_d"
          ];
        };
        format = {
          enable = true;
          type = "prettier";
        };
        lsp = {
          enable = true;
        };
        treesitter = {
          enable = true;
        };
      };

      yaml = {
        enable = true;
        lsp = {
          enable = true;
        };
        treesitter = {
          enable = true;
        };
      };
    };
  };
}

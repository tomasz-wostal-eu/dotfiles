return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      require("lspconfig").lua_ls.setup { capabilites = capabilities }
      require("lspconfig").terraformls.setup { capabilities = capabilities }
      require("lspconfig").bashls.setup { capabilities = capabilities }
      require("lspconfig").autotools_ls.setup { capabilities = capabilities }
      require("lspconfig").awk_ls.setup { capabilities = capabilities }
      require("lspconfig").cmake.setup { capabilities = capabilities }
      require("lspconfig").csharp_ls.setup { capabilities = capabilities }
      require("lspconfig").angularls.setup { capabilities = capabilities }
      require("lspconfig").css_variables.setup { capabilities = capabilities }
      require("lspconfig").cssls.setup { capabilities = capabilities }
      require("lspconfig").docker_compose_language_service.setup { capabilities = capabilities }
      require("lspconfig").dockerls.setup {
        capabilities = capabilities,
        settings = {
          docker = {
            languageserver = {
              formatter = {
                ignoreMultilineInstructions = false,
              },
            },
          }
        }
      }
      require("lspconfig").helm_ls.setup { capabilities = capabilities }
      require("lspconfig").jinja_lsp.setup { capabilities = capabilities }
      require("lspconfig").jqls.setup { capabilities = capabilities }
      -- require("lspconfig").lsp_ai.setup { capabilities = capabilities }
      require("lspconfig").markdown_oxide.setup { capabilities = capabilities }
      require("lspconfig").marksman.setup { capabilities = capabilities }
      require("lspconfig").nil_ls.setup { capabilities = capabilities }
      require("lspconfig").nixd.setup { capabilities = capabilities }
      require("lspconfig").nushell.setup { capabilities = capabilities }
      require("lspconfig").nxls.setup { capabilities = capabilities }
      require("lspconfig").pyright.setup { capabilities = capabilities }
      require("lspconfig").rust_analyzer.setup { capabilities = capabilities }
      require("lspconfig").ts_ls.setup { capabilities = capabilities }
      require("lspconfig").yamlls.setup {
        capabilities = capabilities,
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            },
          },
        },
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local c = vim.lsp.get_client_by_id(args.data.client_id)
          if not c then return end

          if c.supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
              end,
            })
          end
        end,
      })
    end,
  },
}

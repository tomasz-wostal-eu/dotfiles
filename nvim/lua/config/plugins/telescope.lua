return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            theme = "ivy"
          }
        },
        extensions = {
          fzf = {}
        }
      }

      -- Enable telescope-fzf-native
      require('telescope').load_extension('fzf')

      -- Enable git worktrees
      -- require('telescope').load_extension('git_worktree')

      vim.keymap.set("n", "<space>sc", function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath("config")
        }
      end, { desc = '[S]earch [C]onfig' })

      vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

      vim.keymap.set('n', '<leader>sf', function()
        require('telescope.builtin').find_files { hidden = true }
      end, { desc = '[S]earch [F]iles' })

      vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })

      vim.keymap.set("n", "<space>sh", require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })

      vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })

      vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })


      -- vim.keymap.set("n", "<Leader>sn", "<CMD>lua require('telescope').extensions.notify.notify()<CR>", silent)

      vim.api.nvim_set_keymap("n", "st", ":TodoTelescope<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<Leader><tab>", "<Cmd>lua require('telescope.builtin').commands()<CR>",
        { noremap = false })

      vim.keymap.set("n", "<space>sp", function()
        require('telescope.builtin').find_files {
          cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
        }
      end, { desc = '[S]earch [P]lugins' })

      require "config.telescope.multigrep".setup()
    end
  }
}

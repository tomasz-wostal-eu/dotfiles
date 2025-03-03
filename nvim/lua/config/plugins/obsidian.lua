return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "second-brain",
        path = "~/second-brains/second-brain",
      },
      -- {
      --   name = "work",
      --   path = "~/vaults/work",
      -- },
    },
    completion = {
      -- nvim_cmp = true,
      min_chars = 2,
    },
    templates = {
      folder = "templates",
    },
    picker = {
      name = "telescope.nvim",
      mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
    },
  },
}

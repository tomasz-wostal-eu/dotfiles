return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "macchiato", -- latte, frappe, macchiato, mocha
            background = {   -- :h background
                light = "latte",
                dark = "mocchiato",
            },
            transparent_background = false, -- disables setting the background color.
            show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
            term_colors = false,      -- sets terminal colors (e.g. `g:terminal_color_0`)
            dim_inactive = {
                enabled = true,       -- dims the background color of inactive window
                shade = "dark",
                percentage = 0.15,    -- percentage of the shade to apply to the inactive window
            },
            no_italic = false,        -- Force no italic
            no_bold = false,          -- Force no bold
            no_underline = false,     -- Force no underline
            styles = {                -- Handles the styles of general hi groups (see `:h highlight-args`):
                comments = { "italic" }, -- Change the style of comments
                conditionals = { "italic" },
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
                -- miscs = {}, -- Uncomment to turn off hard-coded styles
            },
            color_overrides = {},
            custom_highlights = {},
            default_integrations = true,
            integrations = {
                cmp = true,
                noice = true,
                gitsigns = true,
                nvimtree = true,
                treesitter_context = true,
                treesitter = true,
                notify = true,
                harpoon = true,
                mason = true,
                markdown = true,
                notifier = true,
                dap = true,
                dap_ui = true,
                nvim_surround = true,
                ts_rainbow2 = true,
                ts_rainbow = true,
                window_picker = true,
                rainbow_delimiters = true,
                lsp_trouble = true,
                which_key = true,
                telescope = {
                    enabled = true,
                    -- style = "nvchad"
                },
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                        ok = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                        ok = { "underline" },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
            },
        })

        -- setup must be called before loading
        vim.cmd.colorscheme "catppuccin"
    end,
}


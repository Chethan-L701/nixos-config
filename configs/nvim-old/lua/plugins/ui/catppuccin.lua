return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    -- priority = 1000,
    opts = {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = {     -- :h background
            light = "latte",
            dark = "mocha",
        },
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
        term_colors = true,            -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
            enabled = false,           -- dims the background color of inactive window
            shade = "dark",
            percentage = 0.15,         -- percentage of the shade to apply to the inactive window
        },
        no_italic = false,             -- Force no italic
        no_bold = false,               -- Force no bold
        no_underline = false,          -- Force no underline
        styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = { "italic" },   -- Change the style of comments
            conditionals = { "italic" },
            loops = { "italic" },
            functions = { "bold" },
            keywords = { "bold" },
            strings = { "italic" },
            variables = { "italic" },
            numbers = {},
            booleans = {},
            properties = { "italic" },
            types = { "bold" },
            operators = {},
        },
        custom_highlights = function(colors)
            return {
                CmpItemMenu = { bg = colors.base },
                CmpNormal = { bg = colors.crust },
                LineNrAbove = { fg = colors.lavender },
                LineNrBelow = { fg = colors.lavender },
                CursorLineNr = { fg = colors.blue },
            }
        end,
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            notify = true,
            mini = false,
            alpha = true,
            lsp_trouble = true,
            which_key = true,
            bufferline = true,
            symbols_outline = true,
            --indent_blankline = true,
            neotree = true,
            telescope = {
                enabled = true,
                style = "nvchad",
            },
            barbecue = {
                dim_dirname = true, -- directory name is dimmed by default
                bold_basename = true,
                dim_context = false,
                alt_background = false,
            },
            dap = {
                enabled = true,
                enable_ui = true, -- enable nvim-dap-ui
            },
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
        options = {},
    },
}

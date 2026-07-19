return {
    { "folke/neodev.nvim", opts = {}, lazy = true, ft = { "lua" } },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}, -- this is equalent to setup({}) function
    },
    {
        "rachartier/tiny-code-action.nvim",
        dependencies = { "folke/snacks.nvim" },
        event = "LspAttach",
        opts = {
            backend = "delta",
            picker = {
                "buffer",
                opts = {
                    hotkeys = true,                       -- Enable hotkeys for quick selection of actions
                    hotkeys_mode = "text_diff_based",     -- Modes for generating hotkeys
                    auto_preview = false,                 -- Enable or disable automatic preview
                    auto_accept = false,                  -- Automatically accept the selected action (with hotkeys)
                    position = "cursor",                  -- Position of the picker window
                    winborder = "single",                 -- Border style for picker and preview windows
                    keymaps = {
                        preview = "K",                    -- Key to show preview
                        close = { "q", "<Esc>" },         -- Keys to close the window (can be string or table)
                        select = "<CR>",                  -- Keys to select action (can be string or table)
                        preview_close = { "q", "<Esc>" }, -- Keys to return from preview to main window (can be string or table)
                    },
                    custom_keys = {
                        { key = 'm', pattern = 'Fill match arms' },
                        { key = 'r', pattern = 'Rename.*' }, -- Lua pattern matching
                    },
                    group_icon = " └",
                },
            },
        },
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
        lazy = false,
        keys = {
            { "gc", desc = "comment current line" },
            { "gb", desc = "comment the selected lines" },
        },
    },
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        lazy = false,
    },
    -- /does not seem to be working for some reason
    -- {
    --     "HiPhish/rainbow-delimiters.nvim",
    --     config = function()
    --         ---@type rainbow_delimiters.config
    --         vim.g.rainbow_delimiters = {
    --             strategy = {
    --                 [""] = "rainbow-delimiters.strategy.global",
    --                 vim = "rainbow-delimiters.strategy.local",
    --             },
    --             query = {
    --                 [""] = "rainbow-delimiters",
    --                 lua = "rainbow-blocks",
    --             },
    --             priority = {
    --                 [""] = 110,
    --                 lua = 210,
    --             },
    --             highlight = {
    --                 "RainbowDelimiterRed",
    --                 "RainbowDelimiterYellow",
    --                 "RainbowDelimiterBlue",
    --                 "RainbowDelimiterOrange",
    --                 "RainbowDelimiterGreen",
    --                 "RainbowDelimiterViolet",
    --                 "RainbowDelimiterCyan",
    --             },
    --         }
    --     end,
    -- },
}

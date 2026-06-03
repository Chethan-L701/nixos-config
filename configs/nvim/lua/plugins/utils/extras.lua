return {
    { "folke/neodev.nvim", opts = {}, lazy = true, ft = { "lua" } },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}, -- this is equalent to setup({}) function
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

return {
    { "folke/neodev.nvim", opts = {} },
    {
        "Pocco81/auto-save.nvim",
        lazy = true,
        config = function()
            require("auto-save").setup({
                enabled = false,
                trigger_events = { "VimLeavePre", "BufLeave", "BufEnter", "WinClose" },
            })
        end,
        keys = {
            { "<leader>as", "<cmd>ASToggle<cr>", desc = "Toggle Auto Save" }
        }
    },
    {
        "chentoast/marks.nvim",
        config = function()
            require("marks").setup()
        end
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}, -- this is equalent to setup({}) function
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        lazy = false,
        config = function()
            require("ibl").setup({ scope = { enabled = false } })
        end,
    },
    {
        "mbbill/undotree",
        lazy = true,
        keys = {
            { "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
        },
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
        lazy = false,
        keys = {
            { "gcc", desc = "comment current line" },
            { "gbc", desc = "comment the selected lines" },
        },
    },
}

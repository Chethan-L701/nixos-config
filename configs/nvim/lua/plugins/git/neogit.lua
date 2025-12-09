return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",  -- required
            "sindrets/diffview.nvim", -- optional
        },
        config = true,
        lazy = true,
        keys = {
            { "<leader>gg", "<cmd>Neogit<cr>",       desc = "Neogit" },
            { "<leader>dv", desc = "Diffview Toggle" }
        },
        cmd = "Neogit",
    },
    {
        "sindrets/diffview.nvim", -- optional
        config = true,
        lazy = true,
        keys = {
            { "<leader>dv", desc = "Diffview Toggle" }
        },
        cmd = "DiffviewOpen"
    }

}

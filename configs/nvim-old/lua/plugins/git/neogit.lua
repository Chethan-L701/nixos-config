return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",         -- required
        "nvim-telescope/telescope.nvim", -- optional
        "sindrets/diffview.nvim",        -- optional
    },
    config = true,
    lazy = true,
    keys = {
        { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
    cmd = "Neogit",
}

return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    lazy = true,
    config = true,
    keys = {
        { "<leader>xx", "<cmd>Trouble lsp toggle<cr>",      desc = "Toggle Trouble" },
        {
            "<leader>xw",
            "<cmd>Trouble lsp_definations toggle<cr>",
            desc = "Toggle LSP defination",
        },
        {
            "<leader>xd",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Toggle Document Diagnostics",
        },
        { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",  desc = "Toggle Location List" },
        { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", desc = "Toggle Quickfix" },
        {
            "<leader>xr",
            "<cmd>Trouble lsp_references toggle<cr>",
            desc = "Toggle Trouble Lsp Refereeences",
        },
    },
    cmd = "Trouble",
}

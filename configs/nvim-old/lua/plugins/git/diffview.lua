return {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = "DiffviewOpen",
    keys = {
        { "<leader>dvo", "<cmd>DiffviewOpen<cr>",        desc = "Open Split Diff view" },
        { "<leader>dvc", "<cmd>DiffviewClose<cr>",       desc = "Close Split Diff view" },
        { "<leader>dvl", "<cmd>DiffviewLog<cr>",         desc = "Open Log Diff view" },
        { "<leader>dvr", "<cmd>DiffviewRefresh<cr>",     desc = "Refresh Diff view" },
        { "<leader>dvh", "<cmd>DiffviewFileHistory<cr>", desc = "Open File History Diff view" },
    },
}

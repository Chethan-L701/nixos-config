return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup()
    end,
    lazy = false,
    keys = {
        { "<leader>gs",  desc = "Gitsigns" },
        { "<leader>gse", "<cmd> Gitsigns toggle_signs<cr>",    desc = "Toggle Git Signs" },
        { "<leader>gsb", "<cmd> Gitsigns blame<cr>",           desc = "Toggle Toggle Blame" },
        { "<leader>gss", "<cmd> Gitsigns stage_hunk<cr>",      desc = "Stage Hunk" },
        { "<leader>gsr", "<cmd> Gitsigns reset_hunk<cr>",      desc = "Reset Hunk" },
        { "<leader>gsu", "<cmd> Gitsigns undo_stage_hunk<cr>", desc = "Undo Stage Hunk" },
        { "<leader>gsp", "<cmd> Gitsigns prev_hunk<cr>",       desc = "Previous Hunk" },
        { "<leader>gsv", "<cmd> Gitsigns preview_hunk<cr>",    desc = "Preview Hunk" },
        { "<leader>gsn", "<cmd> Gitsigns next_hunk<cr>",       desc = "Next Hunk" },
    },
}

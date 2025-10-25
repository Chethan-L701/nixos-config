return {
    "folke/which-key.nvim",
    dependencies = { "https://github.com/echasnovski/mini.icons.git" },
    config = function()
        local wk = require("which-key")
        wk.setup({})
        -- wk.register({
        --     f = { name = "Telescope" },
        --     b = { name = "Buffers and Barbecue" },
        --     d = { name = "Dap", t = { name = "Terminate" }, v = { name = "Diffview" } },
        --     g = { name = "Git", s = { name = "Gitsigns" } },
        --     l = { name = "Symbols" },
        --     s = { name = "Symbols Ol" },
        --     r = { name = "Lsp" },
        --     t = { name = "treesitter" },
        --     x = { name = "Trouble" },
        --     c = { name = "Code Actions" },
        --     o = { name = "Oil" },
        --     w = { name = "Workspace" },
        --     u = { name = "Undo" },
        -- }, { prefix = "<leader>" })
        wk.add({
            { "<leader>f",  group = "Telescope" },
            { "<leader>b",  group = "Buffers and Barbecue" },
            { "<leader>d",  group = "Dap" },
            { "<leader>dt", group = "Terminate" },
            { "<leader>dv", group = "Diffview" },
            { "<leader>g",  group = "GIt" },
            { "<leader>gs", group = "GitSigns" },
            { "<leader>l",  group = "Symbols" },
            { "<leader>s",  group = "Symbols Oil" },
            { "<leader>r",  group = "Lsp" },
            { "<leader>t",  group = "treesitter" },
            { "<leader>x",  group = "Trouble" },
            { "<leader>c",  group = "Code Actions" },
            { "<leader>o",  group = "Oil" },
            { "<leader>w",  group = "Workspace" },
            { "<leader>u",  group = "Undo" }
        })
    end,
    lazy = false,
}

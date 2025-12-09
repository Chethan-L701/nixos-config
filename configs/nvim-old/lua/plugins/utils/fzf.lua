return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = true,
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({})
    end,
    keys = {
        { "<leader>fz", "<cmd>FzfLua builtin<cr>", desc = "Open fzf lua builtins window" },
    },
}

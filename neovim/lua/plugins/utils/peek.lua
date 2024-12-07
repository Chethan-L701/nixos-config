return {
    "toppair/peek.nvim",
    lazy = true,
    ft = "md",
    build = "deno task --quiet build:fast",
    config = function()
        require("peek").setup()
        -- refer to `configuration to change defaults`
        vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
        vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        vim.keymap.set({ "n", "v" }, "<leader>mko", function()
            require("peek").open()
        end, { desc = "open markdown preview" })
        vim.keymap.set({ "n", "v" }, "<leader>mkc", function()
            require("peek").open()
        end, { desc = "close markdown preview" })
    end,
    keys = {
        { "<leader>mdo" },
        { "<leader>mdc" },
    },
}

return {
    "rasulomaroff/reactive.nvim",
    lazy = true,
    config = function()
        require("reactive").setup({
            builtin = {
                cursorline = true,
                cursor = true,
                modemsg = true,
            },
        })
        __reactive_active = false
        vim.cmd([[ReactiveStop]])
    end,
    keys = {
        {
            "<leader>rt",
            function()
                if __reactive_active then
                    vim.cmd([[ReactiveStop]])
                    __reactive_active = false
                else
                    vim.cmd([[ReactiveStart]])
                    __reactive_active = true
                end
            end,
            desc = "Toggle Reactive Cursor Line",
        },
    },
}

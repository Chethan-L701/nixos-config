return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        local Terminal = require("toggleterm.terminal").Terminal
        local nu_float = Terminal:new({ cmd = "nu", hidden = true, direction = "float" })
        local nu_hor = Terminal:new({ cmd = "nu", hidden = true, direction = "horizontal" })

        function nu_term_float()
            nu_float:toggle()
        end

        function nu_term_hor()
            nu_hor:toggle()
        end

        require("toggleterm").setup()
    end,
    lazy = true,
    keys = {
        {
            "<M-\\>",
            function()
                if vim.loop.os_uname().sysname == "Windows_NT" then
                    nu_term_float()
                else
                    vim.cmd([[ToggleTerm direction=float]])
                end
            end,
            desc = "horizontal Toggle Term",
            mode = { "t", "n" }
        },
        {
            "<C-\\>",
            function()
                if vim.loop.os_uname().sysname == "Windows_NT" then
                    nu_term_hor()
                else
                    vim.cmd([[ToggleTerm direction=horizontal]])
                end
            end,
            desc = "horizontal Toggle Term",
            mode = { "t", "n" }
        },
    },
}

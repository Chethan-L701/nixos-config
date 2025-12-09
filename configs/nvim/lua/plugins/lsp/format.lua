return {
    "mhartington/formatter.nvim",
    lazy = true,
    config = function()
        local util = require("formatter.util")
        -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
        require("formatter").setup({
            -- Enable or disable logging
            logging = true,
            -- Set the log level
            log_level = vim.log.levels.WARN,
            -- All formatter configurations are opt-in
            filetype = {
                -- Formatter configurations for filetype "lua" go here
                -- and will be executed in order
                lua = {
                    require("formatter.filetypes.lua").stylua,
                },
                cpp = {
                    require("formatter.filetypes.cpp").clangformat,
                },
                java = {
                    require("formatter.filetypes.java").clangformat,
                },
                python = {
                    require("formatter.filetypes.python").autopep8,
                },
                rust = {
                    require("formatter.filetypes.rust").rustfmt,
                },
                html = {
                    require("formatter.filetypes.html").prettier,
                },
                javascript = {
                    require("formatter.filetypes.javascript").prettier,
                },
                typescript = {
                    require("formatter.filetypes.typescript").prettier,
                },
                css = {
                    require("formatter.filetypes.css").prettier,
                },
                json = {
                    require("formatter.filetypes.json").prettier,
                },
            },
        })
    end,
    keys = {
        { "<leader>fm", "<cmd>FormatWrite<cr>", desc = "Format" },
        { "<leader>fm", "<cmd>FormatWrite<cr>", mode = "v",     desc = "Format" },
    },
}

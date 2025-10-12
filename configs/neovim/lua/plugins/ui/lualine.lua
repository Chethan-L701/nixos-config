return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
        -- Lsp server name .
        local colors = {
            darkgray = "none",
            text0 = "#bbbbff",
            innerbg = nil,
            outerbg = "none",
            normal = "#7198fa",
            insert = "#aaffaa",
            visual = "#8888ff",
            replace = "#e46876",
            command = "#ddcc88",
            text = "#212121",
        }
        require("lualine").setup({
            options = {
                theme = function()
                    return {
                        inactive = {
                            a = { bg = colors.outerbg, gui = "bold" },
                            b = { bg = colors.outerbg },
                            c = { bg = colors.innerbg },
                        },
                        visual = {
                            a = { fg = colors.visual, gui = "bold" },
                            b = { bg = colors.outerbg },
                            c = { bg = colors.innerbg },
                        },
                        replace = {
                            a = { fg = colors.replace, gui = "bold" },
                            b = { bg = colors.outerbg },
                            c = { bg = colors.innerbg },
                        },
                        normal = {
                            a = { fg = colors.normal, gui = "bold" },
                            b = { bg = colors.outerbg },
                            c = { bg = colors.innerbg },
                        },
                        insert = {
                            a = { fg = colors.insert, gui = "bold" },
                            b = { bg = colors.outerbg },
                            c = { bg = colors.innerbg },
                        },
                        command = {
                            a = { fg = colors.command, gui = "bold" },
                            b = { bg = colors.outerbg, fg = "#aaaadd" },
                            c = { bg = colors.innerbg },
                        },
                    }
                end,
                -- section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                --
                lualine_a = {
                    { "mode", icon = "" },
                },
                lualine_b = {
                    {
                        function()
                            local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
                            return dir
                        end,
                        color = { bold = true }
                    },
                    { "branch", color = { fg = "#ff7788" } },
                    { "diff", symbols = { added = " ", modified = " ", removed = " " } },
                    { "diagnostics", symbols = { error = " ", warn = " ", info = " " } },
                },
                lualine_x = {
                    {
                        function()
                            local msg = ""
                            local buf_ft = vim.api.nvim_get_option_value('filetype', {})
                            local clients = vim.lsp.get_clients({ bufrnr })
                            if next(clients) == nil then
                                return msg
                            end
                            for _, client in ipairs(clients) do
                                local filetypes = client.config.filetypes
                                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                    return client.name
                                end
                            end
                            return msg
                        end,
                        icon = " ",
                        on_click = function()
                            vim.cmd([[LspInfo]])
                        end,
                    },
                    "filetype",
                },
                lualine_z = {
                    "location",
                    "os.date('%a %H:%M:%S')",
                    {
                        function()
                            if vim.loop.os_uname().sysname == "Windows_NT" then
                                return ""
                            else
                                return ""
                            end
                        end,
                    },
                },
            },
        })
    end,
    lazy = false,
}

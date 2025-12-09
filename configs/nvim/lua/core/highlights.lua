local M = {}

M.set_highlights = function()
    vim.diagnostic.config({
        virtual_text = {
            prefix = "",
        },

        severity_sort = true,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = " ",
                [vim.diagnostic.severity.INFO] = " ",
                [vim.diagnostic.severity.HINT] = "󰌵",
            },
        },
    })

    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#2e2e3e", bold = true })
    vim.api.nvim_set_hl(0, "Normal", { bg = 'none' })
    vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#2e2e3e", bold = true })
end
---@param colorscheme string
M.set_corscheme = function(colorscheme)
    vim.cmd.colorscheme(colorscheme)
end

return M

-- custom highlights groups
local M = {}
function M.set_highlights()
    vim.api.nvim_set_hl(0, "CmpItemMenu", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
    vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "CursorLineSign", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitsignsCurrentLineBlame", { fg = "#ff7799" })
    vim.api.nvim_set_hl(0, "FidgetTitle", { link = "NormalFloat" })
    vim.api.nvim_set_hl(0, "FidgetTask", { link = "NormalFloat" })
    vim.diagnostic.config({
        virtual_text = {
            prefix = ""
        },
        severity_sort = true,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = " ",
                [vim.diagnostic.severity.INFO] = " ",
                [vim.diagnostic.severity.HINT] = "󰌵",
            }
        }
    })
end

return M

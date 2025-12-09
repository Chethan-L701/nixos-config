local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command
command("QuitNvim", function()
    vim.cmd([[wall!]])
    local sscmd = "mksession! " .. vim.fn.getcwd() .. "/session.vim"
    vim.cmd(sscmd)
    vim.cmd("qa!")
end, {})

autocmd("VimLeavePre", {
    pattern = "*",
    command = "QuitNvim",
})

--- @param scheme string
--- @return nil
--- this function is used to apply colorscheme and them overwrite some of the highlights
ApplyColorscheme = function(scheme)
    local cmd = "colorscheme " .. scheme
    vim.cmd(cmd)
    vim.api.nvim_set_hl(0, "CmpItemMenu", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { link = "DiagnosticError" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { link = "DiagnosticHint" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { link = "DiagnosticInfo" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { link = "DiagnosticWarn" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOk", { link = "DiagnosticOk" })

    vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = nil })
    vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { bg = nil })
end


command("ApplyColorscheme", function()
    local scheme = vim.fn.input("ColorScheme : ", "")
    if scheme == "" then
        scheme = defscheme
    else
        defscheme = scheme
    end
    ApplyColorscheme(scheme)
end, {})

command("LspFormat", function()
    vim.lsp.buf.format()
end, {})

autocmd("BufWrite", {
    pattern = "*",
    command = "LspFormat",
})

command("LoadAllColorSchemes", function()
    vim.cmd([[Lazy load catppuccin kanagawa.nvim onedark.nvim tokyonight.nvim rose-pine]])
end, {})

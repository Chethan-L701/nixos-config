local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

command("LspFormat", function()
    vim.lsp.buf.format()
end, {})

autocmd("BufWritePre", {
    pattern = "*",
    command = "LspFormat",
})

autocmd("VimLeavePre", {
    pattern = "*",
    callback = function()
        local sscmd = "mksession! " .. vim.fn.getcwd() .. "/session.vim"
        vim.cmd(sscmd)
    end,
    desc = "save the current session state in session.vim"
})

autocmd("FileType", {
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})

autocmd("BufWritePost", {
    pattern = "*.go",
    callback = function()
        vim.cmd "lsp restart"
    end,
})

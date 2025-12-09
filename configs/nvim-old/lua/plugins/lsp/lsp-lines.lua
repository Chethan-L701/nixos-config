return {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    opts = true,
    keys = {
        {
            '<leader>le',
            function()
                require('lsp_lines').toggle()
            end,
            mode = 'n',
            desc = "Toggle LSP lines"
        },

    },
    lazy = false
}

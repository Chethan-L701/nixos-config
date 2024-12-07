vim.g.mapleader = " "

vim.keymap.set("n", "<C-s>", function()
    vim.cmd("w")
    local cmd = "mksession! " .. vim.fn.getcwd() .. "/session.vim"
    vim.cmd(cmd)
end, { silent = true, noremap = true })

vim.keymap.set("n", "<C-q>", ":QuitNvim<CR>", { desc = "Quit Nvim" })
vim.keymap.set("n", "!", ":!", { desc = "Shell" })
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>yy", '0v$"+y$', { desc = "copy entire line to system clipboard" })
vim.keymap.set({ "n", "v", "x" }, "<leader>li", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "toggle inlay hints" })
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv") -- Shift visual selected line down
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv") -- Shift visual selected line up
vim.keymap.set({ "n", "t" }, "<M-l>", "<C-w>l")
vim.keymap.set({ "n", "t" }, "<M-h>", "<C-w>h")
vim.keymap.set({ "n", "t" }, "<M-j>", "<C-w>j")
vim.keymap.set({ "n", "t" }, "<M-k>", "<C-w>k")
vim.keymap.set("t", "<Esc>", "<C-\\>")
vim.keymap.set("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "vertical split" })
vim.keymap.set("n", "<leader>-", "<cmd>split<cr>", { desc = "horizontal split" })

vim.keymap.set("n", "<leader>cc", function()
    vim.cmd([[ApplyColorscheme]])
end, { desc = "apply color scheme" })
vim.keymap.set({ "n", "v", "x" }, "<leader>hi", function()
    require("core.highlights").set_highlights()
end, { desc = "highlights" })

vim.keymap.set("n", "+", "<cmd>redo<cr>")
vim.keymap.set("n", "-", "<cmd>undo<cr>")

vim.keymap.set("n", "<leader>sg", function()
    vim.cmd [[Lazy load sg.nvim]]
end, { desc = "load the sourcegraph plugin and enable cody autocompletion" })

vim.keymap.set({ "n", "i" }, "<C-]>", "<cmd>bnext<cr>", { desc = "rotate buffers" })

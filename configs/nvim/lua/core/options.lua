vim.opt.nu = true
vim.opt.rnu = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.wrap = false
vim.opt.cursorline = true
vim.wo.fillchars = "eob: "
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"
vim.opt.pumheight = 15
-- vim.opt.cmdheight = 0

vim.opt.termguicolors = true
vim.o.guicursor = [[i-ci:hor15]]

vim.o.undofile = true

if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.o.undodir = "C:\\Users\\Cheth\\AppData\\Local\\nvim-data\\undotree\\"
else
    vim.o.undodir = vim.loop.os_homedir() .. "/.nvim/undotree/"
end

vim.o.updatetime = 50

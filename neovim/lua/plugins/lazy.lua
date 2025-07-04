local vim = vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    { import = "plugins.treesitter" },
    { import = "plugins.ui" },
    { import = "plugins.utils" },
    { import = "plugins.lsp" },
    { import = "plugins.git" },
    { import = "plugins.latex" }
}, {
    lockfile = vim.fn.getenv('HOME') .. "/lazy-lock.json",
    install = {
        missing = true,
        colorscheme = { defscheme },
    },
    ui = {
        border = "double",
        size = {
            width = 0.8,
            height = 0.8,
        },
    },
})

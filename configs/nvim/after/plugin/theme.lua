vim.cmd.colorscheme "catppuccin"

-- local ok, theme = pcall(require, "core.colors")
--
-- if ok then
--     for group, opts in pairs(theme.highlights) do
--         vim.api.nvim_set_hl(0, group, opts)
--     end
-- else
--     vim.cmd.colorscheme("catppuccin")
-- end

require("core.highlights").set_highlights()

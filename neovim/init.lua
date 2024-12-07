defscheme = "catppuccin"
require("core")
require("plugins.lazy")
if vim.g.neovide then
    require("extras.neovide")
end
require("core.highlights").set_highlights()

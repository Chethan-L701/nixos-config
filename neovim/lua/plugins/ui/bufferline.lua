return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("bufferline").setup({
            options = {
                highlight = {},
                groups = {
                    items = {
                        require("bufferline.groups").builtin.pinned:with({ icon = "󰈸" }),
                    },
                },
                themable = true,
                max_name_length = 25,
                truncate_names = false, -- whether or not tab names should be truncated
                diagnostics = "nvim_lsp",
                diagnostics_update_in_insert = false,
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local str = " "
                    for i, n in pairs(diagnostics_dict) do
                        local icon = (i == "error" and "") or (i == "warning" and "" or "")
                        str = str .. n .. " " .. icon .. " "
                    end
                    return str
                end,
                color_icons = true,
                buffer_close_icon = "󰅖",
                modified_icon = "●",
                close_icon = "",
                left_trunc_marker = "",
                right_trunc_marker = "",
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { "close" },
                },
                separator_style = "sloped",
                numbers = function(opts)
                    return string.format("%s·", opts.ordinal)
                end,
            }
        })
    end,
    keys = {
        { "<leader>bn",  "<cmd>BufferLineCycleNext<cr>",       desc = "Next Buffer" },
        { "<leader>bp",  "<cmd>BufferLineCyclePrev<cr>",       desc = "Prev Buffer" },
        { "<leader>bd",  "<cmd>BufferLinePickClose<cr>",       desc = "Close Buffer" },
        { "<leader>bb",  "<cmd>BufferLinePick<cr>",            desc = "Pick Buffer" },
        { "<leader>bc",  "<cmd>BufferLinePickClose<cr>",       mode = "v",                desc = "Pick Buffer" },
        { "<leader>bst", "<cmd>BufferLineSortByTabs<cr>",      desc = "Sort by Tabs" },
        { "<leader>bsd", "<cmd>BufferLineSortByDirectory<cr>", desc = "Sort by Directory" },
        { "<leader>bse", "<cmd>BufferLineSortByExtension<cr>", desc = "Sort by Extension" },
        { "<leader>bx",  "<cmd>BufferLineTogglePin<cr>",       desc = "Pin Buffer" },

        { "<M-1>",       "<cmd>BufferLineGoToBuffer 1<cr>",    desc = "Buffer 1" },
        { "<M-2>",       "<cmd>BufferLineGoToBuffer 2<cr>",    desc = "Buffer 2" },
        { "<M-3>",       "<cmd>BufferLineGoToBuffer 3<cr>",    desc = "Buffer 3" },
        { "<M-4>",       "<cmd>BufferLineGoToBuffer 4<cr>",    desc = "Buffer 4" },
        { "<M-5>",       "<cmd>BufferLineGoToBuffer 5<cr>",    desc = "Buffer 5" },
        { "<M-6>",       "<cmd>BufferLineGoToBuffer 6<cr>",    desc = "Buffer 6" },
        { "<M-7>",       "<cmd>BufferLineGoToBuffer 7<cr>",    desc = "Buffer 7" },
        { "<M-8>",       "<cmd>BufferLineGoToBuffer 8<cr>",    desc = "Buffer 8" },
        { "<M-9>",       "<cmd>BufferLineGoToBuffer 10<cr>",   desc = "Buffer 9" },
    },
    lazy = true,
}

local opts = {
    window = {
        mappings = {
            ["P"] = { "toggle_preview", config = { use_float = true } },
        },
    },
    filesystem = {
        filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false, -- only works on Windows for hidden files/directories
            hide_by_name = {
                ".DS_Store",
                "thumbs.db",
                ".git",
                --"node_modules",
            },
            hide_by_pattern = {
                --"*.meta",
                --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
                --".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                --".DS_Store",
                --"thumbs.db",
            },
            never_show_by_pattern = { -- uses glob style patterns
                --".null-ls_*",
            },
        },
    },
    default_component_configs = {
        indent = {
            with_expanders = true,
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
        },
        diagnostics = {
            symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = "󰌵",
            },
        },
    },
    source_selector = {
        winbar = false, -- toggle to show selector on winbar
        statusline = false, -- toggle to show selector on statusline
        show_scrolled_off_parent_node = false, -- boolean
        sources = { -- table
            {
                source = "filesystem", -- string
                display_name = " 󰉓 Files ", -- string | nil
            },
            {
                source = "buffers", -- string
                display_name = " 󰈚 Buffers ", -- string | nil
            },
            {
                source = "git_status", -- string
                display_name = " 󰊢 Git ", -- string | nil
            },
        },
        content_layout = "start", -- string
        tabs_layout = "equal", -- string
        truncation_character = "…", -- string
        tabs_min_width = nil, -- int | nil
        tabs_max_width = 20, -- int | nil
        padding = 0, -- int | { left: int, right: int }
        separator = { left = "▏", right = "▕" }, -- string | { left: string, right: string, override: string | nil }
        separator_active = nil, -- string | { left: string, right: string, override: string | nil } | nil
        show_separator_on_edge = false, -- boolean
        highlight_tab = "NeoTreeTabInactive", -- string
        highlight_tab_active = "NeoTreeTabActive", -- string
        highlight_background = "NeoTreeTabInactive", -- string
        highlight_separator = "NeoTreeTabSeparatorInactive", -- string
        highlight_separator_active = "NeoTreeTabSeparatorActive", -- string
    },
}

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    lazy = true,
    config = function()
        require("neo-tree").setup(opts)
    end,
    keys = {
        { "<leader>ex", "<cmd>Neotree toggle<CR>", desc = "Toggle NeoTree" },
    },
    cmd = "Neotree",
}

return {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("telescope").setup({
            pickers = {},
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "-L",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                -- 
                prompt_prefix = "   ",
                selection_caret = "❯",
                entry_prefix = "",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "descending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "bottom",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                file_ignore_patterns = { "node_modules" },
                generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                path_display = { "truncate" },
                winblend = 0,
                border = true,
                borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                color_devicons = true,
                set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                -- Developer configurations: Not meant for general override
                buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
                mappings = {},
            },
            extensions_list = { "themes", "terms" },
        })
        vim.keymap.set({ "n", "v" }, "<leader>fg", function()
            require("telescope.builtin").git_files()
        end, { desc = "grep git files" })
        vim.keymap.set({ "n", "v" }, "<leader>ff", function()
            require("telescope.builtin").find_files()
        end, { desc = "grep git files" })
        vim.keymap.set({ "n", "v" }, "<leader>fa", function()
            require("telescope.builtin").find_files({ hidden = true })
        end, { desc = "grep git files" })
    end,
    keys = {
        { "<leader>ff", desc = "Find Files" },
        { "<leader>fa", desc = "Find all files" },
        { "<leader>fg", desc = "Find Git Files" },
        { "<leader>fw", "<cmd>Telescope live_grep<cr>",                     desc = "Find Text" },
        { "<leader>fv", "<cmd>Telescope grep_string<cr>",                   desc = "Find Text" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>",                       desc = "Find Buffers" },
        { "<leader>fd", "<cmd>Telescope diagnostics<cr>",                   desc = "Find Diagnostics" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>",                     desc = "Find Help" },
        { "<leader>fk", "<cmd>Telescope keymaps<cr>",                       desc = "Find Keymaps" },
        { "<leader>fc", "<cmd>Telescope commands<cr>",                      desc = "Find Commands" },
        -- git
        { "<leader>gc", "<cmd>Telescope git_commits<cr>",                   desc = "Git Commits" },
        { "<leader>gb", "<cmd>Telescope git_branches<cr>",                  desc = "Git Branches" },
        { "<leader>fs", "<cmd>Telescope git_stash<cr>",                     desc = "Git Stashes" },
        -- lsp
        { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>",          desc = "Document Symbols" },
        { "<leader>lw", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
        { "<leader>lr", "<cmd>Telescope lsp_references<cr>",                desc = "References" },
    },
}

return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local util = require("lspconfig.util")
            vim.lsp.config("lua_ls", {
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    local runtimepath = vim.api.nvim_get_runtime_file("", true)
                    if
                        not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc")
                    then
                        client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
                            Lua = {
                                runtime = {
                                    version = "LuaJIT",
                                },
                                workspace = {
                                    checkThirdParty = false,
                                    library = runtimepath,
                                },
                                diagnostics = {},
                                telemetry = { enable = false },
                                hint = {
                                    enable = true,
                                    arrayIndex = "Disable",
                                    setType = false,
                                    paramName = "Disable",
                                    paramType = true,
                                },
                                codeLens = { enable = true },
                            },
                        })
                        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                    end
                    return true
                end,
            })
            vim.lsp.enable("lua_ls")

            vim.lsp.enable("nixd")
            vim.lsp.enable('hls')
            vim.lsp.enable('ts_ls')

            vim.lsp.config("rust_analyzer", {
                -- Server-specific settings. See `:help lspconfig-setup`
                settings = {
                    ["rust-analyzer"] = {
                        inlayHints = {
                            enable = true,
                            showParameterNames = true,
                            parameterHintsPrefix = "<- ",
                            otherHintsPrefix = "=> ",
                        },
                    },
                },
            })
            vim.lsp.enable("rust_analyzer")
            vim.lsp.enable("clangd")
            vim.lsp.enable('basedpyright')

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open diagnostic Float" })
            vim.keymap.set("n", "[d", function()
                vim.diagnostic.jump({ count = -1 })
            end, { desc = "Goto Previous Error" })
            vim.keymap.set("n", "]d", function()
                vim.diagnostic.jump({ count = 1 })
            end, { desc = "Goto Next Error" })
            vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set Loclist" })

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set(
                        "n",
                        "gD",
                        vim.lsp.buf.declaration,
                        { buffer = opts.buffer, desc = "GOTO Declaration" }
                    )
                    vim.keymap.set(
                        "n",
                        "gd",
                        vim.lsp.buf.definition,
                        { buffer = opts.buffer, desc = "GOTO definition" }
                    )
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = opts.buffer, desc = "Lsp Hover" })
                    vim.keymap.set(
                        "n",
                        "gi",
                        vim.lsp.buf.implementation,
                        { buffer = opts.buffer, desc = "GOTO Implementation" }
                    )
                    vim.keymap.set(
                        "n",
                        "<C-k>",
                        vim.lsp.buf.signature_help,
                        { buffer = opts.buffer, desc = "SIgnature Help" }
                    )
                    vim.keymap.set(
                        "n",
                        "<space>wa",
                        vim.lsp.buf.add_workspace_folder,
                        { buffer = opts.buffer, desc = "Add Workspace" }
                    )
                    vim.keymap.set(
                        "n",
                        "<space>wr",
                        vim.lsp.buf.remove_workspace_folder,
                        { buffer = opts.buffer, desc = "Remove Workspace" }
                    )
                    vim.keymap.set("n", "<space>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set(
                        "n",
                        "<space>D",
                        vim.lsp.buf.type_definition,
                        { buffer = opts.buffer, desc = "Type defination" }
                    )
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = opts.buffer, desc = "Rename" })
                    vim.keymap.set(
                        { "n", "v" },
                        "<leader>ca",
                        vim.lsp.buf.code_action,
                        { buffer = opts.buffer, desc = "Code Actions" }
                    )
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = opts.buffer, desc = "References" })
                    vim.keymap.set("n", "<space>f", function()
                        vim.lsp.buf.format({ async = true })
                    end, opts)
                end,
            })

            local signs = { Error = " ", Warn = " ", Info = " ", Hint = "" }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            require("lspconfig.ui.windows").default_options.border = "double"
        end,
    },
}

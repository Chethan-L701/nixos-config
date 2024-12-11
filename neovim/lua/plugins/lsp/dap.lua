return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
    },
    "theHamsta/nvim-dap-virtual-text",
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "nvim-neotest/nvim-nio",
        },
        lazy = true,
        config = function()
            local dap = require("dap")

            dap.adapters.cppdbg = {
                id = "cppdbg",
                type = "executable",
                command = "/home/kali/.local/share/nvim/mason/bin/OpenDebugAD7",
            }

            dap.configurations.cpp = {
                {
                    name = "lauch (cppdbg)",
                    type = "cppdbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtEntry = true,
                },
                {
                    name = "lauch (gdb)",
                    type = "cppdbg",
                    request = "launch",
                    MIMode = "gdb",
                    miDebuggerPath = "/usr/bin/gdb",
                    cwd = "${workspaceFolder}",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                },
                {
                    name = "lauch gdb with arguments",
                    type = "cppdbg",
                    request = "launch",
                    MIMode = "gdb",
                    miDebuggerPath = "/usr/bin/gdb",
                    cwd = "${workspaceFolder}",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    args = function()
                        local arg_str = vim.fn.input("Arguments: ")
                        return vim.split(arg_str, " ")
                    end,
                },
            }
            dap.configurations.c = dap.configurations.cpp

            -- nvim dap-ui
            require("dapui").setup({
                icons = { expanded = "▾", collapsed = "▸" },
                mappings = {
                    -- Use a table to apply multiple mappings
                },
            })
            local dapui = require("dapui")
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
            -- dap keymaps
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle BreakPoint" })
            vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Dap continue" })
            vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Dap Step Into" })
            vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Dap Step Over" })
            vim.keymap.set("n", "<S-F1>", dap.step_out, { desc = "Dap Step Out" })
            vim.keymap.set("n", "<leader>dr", dap.run_to_cursor, { desc = "Dap Run to Cursor" })
            vim.keymap.set("n", "<leader>dl", dap.list_breakpoints, { desc = "Dap List BreakPoints" })
            vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "Dap Terminate" })
            -- show logs
            vim.keymap.set("n", "<leader>dL", dap.run_last, { desc = "Dap Run Last" })
            -- toggle repl
            vim.keymap.set("n", "<leader>dR", dap.repl.toggle, { desc = "Dap repl toggle" })
            vim.keymap.set("n", "<leader>dtt", dapui.close, { desc = "Dap UI Close" })
            -- setting nerd font f261 for breakpoints

            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "", linehl = "", numhl = "" })
            vim.fn.sign_define("DapLogPoint", { text = "", texthl = "", linehl = "", numhl = "" })
            vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })
        end,
    },
}

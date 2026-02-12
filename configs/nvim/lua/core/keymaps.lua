vim.keymap.set("n", "<C-s>", function()
    vim.cmd([[:w]])
end, { desc = "save the file in the current buffer" })

vim.keymap.set("n", "<Esc>", function()
    vim.cmd([[noh]])
    return "<Esc>"
end, { expr = true })

vim.keymap.set("n", "<leader>fz", function()
    Snacks.picker()
end, { desc = "Snack picker full" })

vim.keymap.set("n", "<leader>gr", function()
    Snacks.picker.lsp_references()
end, { desc = "snacks lsp references" })

vim.keymap.set("n", "<leader>|", function()
    vim.cmd([[:vsplit]])
end, { desc = "horizontal split" })

vim.keymap.set("n", "<leader>-", function()
    vim.cmd([[:split]])
end, { desc = "horizontal split" })

diffview_open = false
vim.keymap.set("n", "<leader>dv", function()
    if diffview_open then
        diffview_open = false
        vim.cmd([[DiffviewClose]])
    else
        diffview_open = true
        vim.cmd([[DiffviewOpen]])
    end
end, { desc = "Diffview Toggle" })

---@param choice string
local make_session = function(choice)
    if choice == "c" or choice == "cancel" or choice == "no" then
        vim.notify("disengaging quit")
    elseif choice == "y" or choice == "yes" then
        vim.cmd([[wa!]])
        vim.cmd([[qa!]])
    elseif choice == "d" or choice == "discard" then
        vim.cmd([[qa!]])
    else
        vim.notify("selceted option: '" .. choice .. "' does not exist.\n" .. [[Select one of the following:
    c -> cancel the prompt
    d -> discard the changes and quit
    y -> save the changes and quit]])
    end
end

vim.keymap.set("t", "<C-/>", function()
    Snacks.terminal()
end, { desc = "Toggle Snack terminal" })

vim.keymap.set("n", "<C-q>", function()
    Snacks.input.input({
        prompt = "do you want to save and exit? y/c/d",
        prompt_pos = "left",
    }, make_session)
end, { desc = "Save all and quit" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "focus left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "focus right window" })
vim.keymap.set("n", "<leader>yy", '"+yy', { desc = "copy the current line to the system clipboard" })
vim.keymap.set({ "v", "n" }, "<leader>y", '"+y', { desc = "copy selection to the system clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "paste from the system keyboard" })
vim.keymap.set("n", "<leader>tD", function()
    OpenFloatingFile("~/todo.md", 0.7)
end, { desc = "open the global todo.md file" })
vim.keymap.set("n", "<leader>td", function()
    local cwd = vim.fn.getcwd()
    OpenFloatingFile(cwd .. "/todo.md", 0.7)
end, { desc = "open the global todo.md file" })

vim.keymap.set("n", "<leader>so",
    function()
        local expanded_path = vim.fn.expand(vim.fn.stdpath('config') .. "/lua/core/options.lua")
        if vim.fn.filereadable(expanded_path) == 1 then
            vim.cmd("source " .. expanded_path)
            print("Sourced: " .. expanded_path)
        else
            print("Error: Could not find file at " .. expanded_path)
        end
    end
);

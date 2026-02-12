local float_win = nil
---@type string
local current_file_name = ""
function OpenFloatingFile(filename, height, width)
    if vim.api.nvim_get_current_win() == float_win then
        if current_file_name == filename then
            vim.api.nvim_win_close(float_win, true)
            float_win = nil
            return
        else
            current_file_name = filename
            vim.cmd("edit" .. filename)
            return
        end
    elseif float_win and vim.api.nvim_win_is_valid(float_win) then
        -- Focus the existing window
        vim.api.nvim_set_current_win(float_win)
    end
    -- Create a new empty buffer
    local buf = vim.api.nvim_create_buf(false, true)
    current_file_name = filename
    local w = 0
    local h = 0

    -- Define the window size and position
    if width ~= nil then
        w = math.ceil(vim.o.columns * width)
    else
        w = math.ceil(vim.o.columns * 0.8)
    end

    if height ~= nil then
        h = math.ceil(vim.o.lines * height)
    else
        h = math.ceil(vim.o.lines * 0.75)
    end
    local win_opts = {
        relative = "editor",
        width = w,
        height = h,
        row = math.ceil((vim.o.lines - h) / 2),
        col = math.ceil((vim.o.columns - w) / 2),
        style = "minimal",
        border = "rounded",
    }

    -- Open the window and load the file into the buffer
    --
    if filename ~= nil then
        float_win = vim.api.nvim_open_win(buf, true, win_opts)
        vim.cmd("edit " .. filename)
    else
        vim.print("filename cannot be nil")
    end
end

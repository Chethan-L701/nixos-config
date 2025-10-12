local opts = {
    kinds = {
        Folder = "󰉋",
        File = "",
        Module = "",
        Namespace = " ",
        Package = "󰏓",
        --󰠱
        Class = "",
        Method = "",
        Property = "󰜢",
        Field = "",
        Constructor = "",
        Enum = "",
        Interface = "",
        Function = "󰊕",
        Variable = "",
        Constant = "󰏿",
        String = "",
        Number = "",
        Boolean = "",
        Array = "",
        Object = "",
        Key = "",
        Null = "",
        EnumMember = "",
        Struct = "",
        Event = "",
        Operator = "󰆕 ",
        TypeParameter = " ",
    },
    attach_navic = true,
    symbols = {
        separator = "",
    },
    theme = {
        normal = { fg = "#c0caf5" },
        dirname = { bold = true },
        basename = { bold = true, italic = true },
        context = { italic = true },
    },
}
return {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
        require("barbecue").setup(opts)
    end,
    keys = {
        { "<leader>b", desc = "Buffer" },
        {
            "<leader>be",
            function()
                require("barbecue.ui").toggle()
            end,
            desc = "Toggle Barbecue UI",
        },
    },
    lazy = false,
}

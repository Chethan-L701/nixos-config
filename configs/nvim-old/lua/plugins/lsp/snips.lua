return {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "rafamadriz/friendly-snippets",
        "honza/vim-snippets",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        -- require("luasnip.loaders.from_snipmate").lazy_load()
        local ls = require("luasnip")
        local s = ls.snippet
        local cn = ls.choice_node
        local sn = ls.snippet_node
        local isn = ls.indent_snippet_node
        local t = ls.text_node
        local i = ls.insert_node
        local f = ls.function_node
        local d = ls.dynamic_node
        local r = ls.restore_node
        local events = require("luasnip.util.events")
        local ai = require("luasnip.nodes.absolute_indexer")
        local extras = require("luasnip.extras")
        local l = extras.lambda
        local rep = extras.rep
        local p = extras.partial
        local m = extras.match
        local n = extras.nonempty
        local dl = extras.dynamic_lambda
        local fmt = require("luasnip.extras.fmt").fmt
        local fmta = require("luasnip.extras.fmt").fmta
        local conds = require("luasnip.extras.expand_conditions")
        local postfix = require("luasnip.extras.postfix").postfix
        local types = require("luasnip.util.types")
        local parse = require("luasnip.util.parser").parse_snippet
        local ms = ls.multi_snippet
        local k = require("luasnip.nodes.key_indexer").new_key

        ls.add_snippets("all", {
            s(
                "curtime",
                f(function()
                    return os.date("%D - %H:%M")
                end)
            ),
            s("ntodo", fmt([[NOT TODO {}]], i(1))),
            s(
                "fpath",
                fmt(
                    [[
                {}
                ]],
                    f(function()
                        return vim.fn.expand("%:p")
                    end)
                )
            ),
            s(
                "rpath",
                fmt(
                    [[
                {}
                ]],
                    f(function()
                        return vim.fn.expand("%:R")
                    end)
                )
            ),
        })
        ls.add_snippets("cpp", {
            s(
                "cppcomp",
                fmt(
                    [[
                #include<iostream>
                #include<vector>
                #include<array>
                using std::vector, std::array;
                int main(int argc, char* argv[]) {{
                    {}
                    return 0;
                }}
                ]],
                    i(1)
                )
            ),
            s(
                "func",
                fmt(
                    [[
                {} {} ({}) {{
                    {}
                    return {};
                }}
                ]],
                    {
                        i(1, "return-type"),
                        i(2, "func-name"),
                        i(3, "args"),
                        i(4),
                        i(5, "value"),
                    }
                )
            ),
        })
    end,
}

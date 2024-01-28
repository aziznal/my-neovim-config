return {
    "L3MON4D3/LuaSnip",
    lazy = "v2.*",
    build = "make install_jsregexp",
    config = function()
        local ls = require("luasnip")
        local extras = require("luasnip.extras")
        local fmt = require("luasnip.extras.fmt").fmt
        local fmta = require("luasnip.extras.fmt").fmta

        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node
        local r = extras.rep -- See docs @https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md

        -- [[ TypeScriptReact Snippets ]]
        ls.add_snippets(
            "typescriptreact",
            {
                s(
                    "cn",
                    {
                        t('className="'),
                        i(1, "class"),
                        t('"')
                    }
                ),
                s(
                    "component",
                    fmt(
                        [[
                            export const Foo = () => {
                                return (
                                    <div>
                                        <h1>Hello World!</h1>
                                    </div>
                                )
                            }
                        ]],
                        {},
                        {
                            delimiters = "`~"
                        }
                    )
                )
            }
        )
    end
}

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
        local rep = extras.rep

        -- [[ See docs @https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md ]]

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
                    "cmp",
                    fmt(
                        [[
                            type `1~Props = {};

                            export const `2~ = (props: `3~Props) => {
                                return (
                                    <div>
                                        <h1>Hello World!</h1>
                                    </div>
                                )
                            }
                        ]],
                        {
                            i(1, "ComponentName"),
                            rep(1),
                            rep(1)
                        },
                        {
                            delimiters = "`~"
                        },
                        {
                            delimiters = "`~"
                        }
                    )
                ),
                s(
                    "cmpdf",
                    fmt(
                        [[
                            type `2~Props = {};

                            export default function `1~(props: `3~Props) {
                                return (
                                    <div>
                                        <h1>Hello World!</h1>
                                    </div>
                                )
                            }
                        ]],
                        {
                            i(1, "ComponentName"),
                            rep(1),
                            rep(1)
                        },
                        {
                            delimiters = "`~"
                        },
                        {
                            delimiters = "`~"
                        }
                    )
                ),
                s(
                    "cmpf",
                    fmt(
                        [[
                            import { forwardRef } from "react";

                            type `1~Props = React.HTMLAttributes<HTMLElement> & {};

                            const `2~ = forwardRef<HTMLElement, `3~Props>(
                              ({ ...props }, ref) => {
                                return (
                                  <div
                                    ref={ref}
                                    {...props}
                                  >
                                    <h1>Hello World!</h1>
                                  </div>
                                );
                              },
                            );

                            `4~.displayName = "`5~";

                            export default `6~;
                        ]],
                        {
                            i(1, "ComponentName"),
                            rep(1),
                            rep(1),
                            rep(1),
                            rep(1),
                            rep(1)
                        },
                        {
                            delimiters = "`~"
                        }
                    )
                ),
                s(
                    "form-item",
                    fmt(
                        [[
                          <FormField
                            control={form.control}
                            name="email"
                            render={({ field }) => (
                              <FormItem>
                                <FormLabel>Email</FormLabel>

                                <FormControl>
                                  <Input type="email" {...field} />
                                </FormControl>

                                <FormMessage />
                              </FormItem>
                            )}
                          />
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

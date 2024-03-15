return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				-- Build Step is needed for regex support in snippets
				-- This step is not supported in many windows environments
				-- Remove the below condition to re-enable on windows
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end

				return "make install_jsregexp"
			end)(),
		},
		"saadparwaiz1/cmp_luasnip",
		-- Adds other completion capabilities.
		--  nvim-cmp does not ship with all sources by default. They are split
		--  into multiple repos for maintenance purposes.
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",

		-- If you want to add a bunch of pre-configured snippets,
		--    you can use this plugin to help you. It even has snippets
		--    for various frameworks/libraries/etc. but you will have to
		--    set up the ones that are useful for you.
		-- 'rafamadriz/friendly-snippets',
	},
	config = function()
		-- See `:help cmp`
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		luasnip.setup()

		local extras = require("luasnip.extras")
		local fmt = require("luasnip.extras.fmt").fmt
		local fmta = require("luasnip.extras.fmt").fmta

		local s = luasnip.snippet
		local t = luasnip.text_node
		local i = luasnip.insert_node
		local rep = extras.rep

		-- [[ See docs @https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md ]]

		-- [[ TypeScriptReact Snippets ]]
		luasnip.add_snippets("typescriptreact", {
			s("cn", {
				t('className="'),
				i(1, "class"),
				t('"'),
			}),
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
						rep(1),
					},
					{
						delimiters = "`~",
					},
					{
						delimiters = "`~",
					}
				)
			),
			s(
				"cmpdf",
				fmt(
					[[
					    type `2~Props = {};

					    export function `1~(props: `3~Props) {
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
						rep(1),
					},
					{
						delimiters = "`~",
					},
					{
						delimiters = "`~",
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

					    export `6~;
					  ]],
					{
						i(1, "ComponentName"),
						rep(1),
						rep(1),
						rep(1),
						rep(1),
						rep(1),
					},
					{
						delimiters = "`~",
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
						delimiters = "`~",
					}
				)
			),

			s(
				"shadcn-dialog-imports",
				fmt(
					[[
						import {
						  Dialog,
						  DialogContent,
						  DialogDescription,
						  DialogHeader,
						  DialogTitle,
						  DialogTrigger,
						} from "@/components/ui/dialog"

					  ]],
					{},
					{
						delimiters = "`~",
					}
				)
			),

			s(
				"shadcn-dialog",
				fmt(
					[[
					<Dialog>
					  <DialogTrigger>Open</DialogTrigger>
					  <DialogContent>
					    <DialogHeader>
					      <DialogTitle>Are you absolutely sure?</DialogTitle>
					      <DialogDescription>
						This action cannot be undone. This will permanently delete your account
						and remove your data from our servers.
					      </DialogDescription>
					    </DialogHeader>
					  </DialogContent>
					</Dialog>
				        ]],
					{},
					{
						delimiters = "`~",
					}
				)
			),
		})

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = { completeopt = "menu,menuone,noinsert" },
			mapping = cmp.mapping.preset.insert({
				-- Select the [n]ext item
				["<C-n>"] = cmp.mapping.select_next_item(),
				-- Select the [p]revious item
				["<C-p>"] = cmp.mapping.select_prev_item(),
				-- Accept ([y]es) the completion.
				--  This will auto-import if your LSP supports it.
				--  This will expand snippets if the LSP sent a snippet.
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				-- Manually trigger a completion from nvim-cmp.
				--  Generally you don't need this, because nvim-cmp will display
				--  completions whenever it has completion options available.
				["<C-Space>"] = cmp.mapping.complete({}),
				-- Think of <c-l> as moving to the right of your snippet expansion.
				--  So if you have a snippet that's like:
				--  function $name($args)
				--    $body
				--  end
				--
				-- <c-l> will move you to the right of each of the expansion locations.
				-- <c-h> is similar, except moving you backwards.
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
			},
		})
	end,
}

return {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		-- works with tags, brackets, quotes, stars, etc.
		--
		-- Shortcuts:
		--
		-- cs: change surround
		--      cs"'  -> "hello" to 'hello'
		--      cs"<q> -> "hello" to <q>hello</q>
		--      csth1 -> "hello" to <h1>hello</h1>
		--
		-- ds: delete surround
		--      ds"   -> "hello" to hello
		--      dsth1 -> <h1>hello</h1> to hello
		--      dsb   -> (hello) to hello
		--      dsf   -> foo(hello) to foo
		--
		-- ys: add surround
		--      ysiw" -> hello to "hello"
		--      yss"  -> hello to "hello"
		--      yss)  -> hello to (hello)
		--      yssb  -> hello to { hello }

		require("nvim-surround").setup({})
	end,
}

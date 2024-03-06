return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	config = function()
		require("ts_context_commentstring").setup({})
		vim.g.skip_ts_context_commentstring_module = 1
	end,
}

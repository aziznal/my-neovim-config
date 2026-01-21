-- for showing lsp load progress
return {
	"j-hui/fidget.nvim",
	tag = "legacy",
	event = "BufRead",
	config = function()
		require("fidget").setup({})
	end,
}

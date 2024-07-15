return {
	"folke/which-key.nvim",
	event = "BufRead",
	config = function()
		require("which-key").setup({
			delay = function(ctx)
				return ctx.plugin and 0 or 1000
			end,
		})
	end,
}

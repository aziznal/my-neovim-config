return {
	"navarasu/onedark.nvim",
	enabled = false,
	config = function()
		require("onedark").setup({
			style = 'deep',
		})

		vim.cmd("colorscheme onedark")
	end,
}

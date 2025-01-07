return {
	"AlexvZyl/nordic.nvim",
	lazy = false,
	priority = 1000,
	enabled = false,
	config = function()
		require("nordic").load()
	end,
}

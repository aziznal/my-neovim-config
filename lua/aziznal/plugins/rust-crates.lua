return {
	"saecki/crates.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	ft = "rust",
	config = function()
		local crates = require("crates")

		crates.setup()
		crates.show()
	end,
}

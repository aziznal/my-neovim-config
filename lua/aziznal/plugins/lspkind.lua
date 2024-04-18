return {
	"onsails/lspkind-nvim",
	config = function()
		require("lspkind").init({})
	end,
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
}

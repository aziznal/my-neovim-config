return {
	"zbirenbaum/copilot.lua",
	event = "BufRead",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = false,
				auto_trigger = true,
				keymap = {
					accept = "<C-a>",
				},
			},
		})
	end,
}

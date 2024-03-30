-- NOTE: install sed and ripgrep for this to work
return {
	"https://github.com/nvim-pack/nvim-spectre",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>S", ":Spectre<CR>", { desc = "Toggle global find and replace" })
	end,
}

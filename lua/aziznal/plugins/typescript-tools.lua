return {
	"pmizio/typescript-tools.nvim",
	requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	config = function()
		require("typescript-tools").setup({})

		vim.cmd(":cnoreabbrev rmu TSToolsRemoveUnusedImports")
		vim.cmd(":cnoreabbrev amu TSToolsAddMissingImports")
	end,
}

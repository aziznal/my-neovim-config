return {
	"pmizio/typescript-tools.nvim",
	requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	config = function()
		require("typescript-tools").setup({})

		-- sometimes I'm too lazy to type the TSTools prefix
		vim.api.nvim_create_user_command("RemoveUnusedImports", function()
			vim.cmd("TSToolsRemoveUnusedImports")
		end, {})

		-- Sometimes I'm too lazy to remember which custom commands I created
		vim.cmd(":cnoreabbrev rmu TSToolsRemoveUnusedImports")
	end,
}

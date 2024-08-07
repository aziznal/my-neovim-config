return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- disable netrw to avoid conflicts
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Main Shortcuts:
		-- <leader><C-e> - toggle tree with current file selected
		-- a - create a file or directory
		-- d - remove a file or directory
		-- r - rename a file or directory

		-- <CR> - expand dir / open file
		-- W - collapse
		-- E - expand recursively
		--
		-- <C-v> - split
		-- <C-x> - vsplitnvim-tree

		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			view = {
				cursorline = true,
				side = "left",
				width = {
					padding = 0,
					min = 45,
				},
			},
			filesystem_watchers = {
				ignore_dirs = {
					"node_modules",
				},
			},
			filters = {
				dotfiles = false,
				git_ignored = false,
			},
			renderer = {
				highlight_opened_files = "name",
				highlight_modified = "name",
				full_name = true,
			},
			git = {
				enable = true,
			},
			update_focused_file = {
				enable = true,
			},
			diagnostics = {
				enable = true,
			},
		})

		vim.keymap.set("n", "<leader><C-n>", ":NvimTreeFindFileToggle<CR>", {
			noremap = true,
			silent = true,
		})
	end,
}

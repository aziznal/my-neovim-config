-- custom status line
return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "moonfly",
				section_separators = {
					left = "",
					right = "",
				},
				component_separators = {
					left = "",
					right = "",
				},
			},
			icons_enabled = true,
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "filetype" },
				lualine_y = { "branch" },
				lualine_z = { "" },
			},
			tabline = {},
			globalstatus = true,
		})
	end,
}

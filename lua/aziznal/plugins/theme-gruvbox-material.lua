return {
	"sainnhe/gruvbox-material",
	enabled = false,
	config = function()
		vim.g.gruvbox_material_enable_italic = true
		vim.g.gruvbox_material_background = "hard"
		vim.cmd("colorscheme gruvbox-material")
	end,
}

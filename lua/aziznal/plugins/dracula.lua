return {
	"Mofiqul/dracula.nvim",
	config = function()
		function ApplyColors(color)
			color = color or "catppuccin"

			vim.cmd.colorscheme(color)
		end

		ApplyColors("dracula")
	end,
}

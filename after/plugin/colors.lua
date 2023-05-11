function ColorMyPencils(color)
	color = color or "github_dark"

	vim.cmd.colorscheme(color)
end

ColorMyPencils()

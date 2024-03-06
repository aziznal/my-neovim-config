return {
	"mbbill/undotree",
	event = "BufRead",
	config = function()
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
	end,
}

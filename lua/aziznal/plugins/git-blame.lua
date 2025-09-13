-- show inline git blame
return {
	"f-person/git-blame.nvim",
	event = "VeryLazy",
	config = function()
		require("gitblame").setup({
			enabled = false,
			message_template = "<author> - <summary> - <date> - <<sha>>",
			message_when_not_committed = "",
			date_format = "%r",
			virutal_text_column = 1,
		})

		vim.cmd(":cnoreabbrev gbe GitBlameEnable")
		vim.cmd(":cnoreabbrev gbd GitBlameDisable")
	end,
}

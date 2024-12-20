return {
	"phelipetls/jsonpath.nvim",
	config = function()
		vim.api.nvim_create_user_command("CopyJsonPath", function()
			pcall(function()
				vim.fn.setreg("+", require("jsonpath").get())
			end)
		end, {})
	end,
}

return {
	"phelipetls/jsonpath.nvim",
	config = function()
		local jsonpath = require("jsonpath")

		vim.api.nvim_create_user_command("CopyJsonPath", function()
			pcall(function()
				vim.fn.setreg("+", jsonpath.get())
			end)
		end, { desc = "Copies the path to json property under the cursor" })

		vim.api.nvim_create_user_command("FindTranslation", function()
			pcall(function()
				local live_grep = require("telescope.builtin").live_grep

				vim.cmd("CopyJsonPath")
				live_grep({
					default_text = jsonpath.get(),
				})
			end)
		end, { desc = "Uses CopyJsonPath then runs toggles a ripgrep search result in telescope using it" })

		vim.keymap.set("n", "<leader>ft", ":FindTranslation<CR>", { silent = true, noremap = true })
	end,
}

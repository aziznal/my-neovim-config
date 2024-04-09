-- https://github.com/stevearc/conform.nvim
return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			notify_on_error = false,

			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				javascript = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },
				javascriptreact = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				markdown = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				jsonc = { { "prettierd", "prettier" } },
			},
		})

		-- format shortcut
		vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua require('conform').format()<CR>", {
			noremap = true,
			silent = true,
			desc = "Format with Conform",
		})
	end,
}

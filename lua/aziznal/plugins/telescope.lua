return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{
			"nvim-telescope/telescope-ui-select.nvim",
		},
	},
	config = function()
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- enabling installed extensions
		pcall(require("telescope").load_extension("fzf"))
		pcall(require("telescope").load_extension("ui-select"))

		local builtin = require("telescope.builtin")

		local function find_files()
			builtin.find_files({
				previewer = false,
				hidden = true,
				file_ignore_patterns = { "node_modules", "dist", "build", "target" },
			})
		end

		local function find_git_files()
			builtin.git_files({
				previewer = false,
				show_untracked = true,
			})
		end

		local function list_buffers()
			builtin.buffers({
				sort_lastused = true,
				previewer = false,
				initial_mode = "normal",
				ignore_current_buffer = true,
			})
		end

		local function grep_string()
			builtin.grep_string({
				search = vim.fn.input("Grep > "),
			})
		end

		local function search_in_file()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end

		local function search_in_neovim_config()
			builtin.find_files({
				cwd = vim.fn.stdpath("config"),
			})
		end

		-- finding files
		vim.keymap.set("n", "<leader>sb", list_buffers, { desc = "List all buffers" })
		vim.keymap.set("n", "<leader>pf", find_git_files, { desc = "Find all files in project" })
		vim.keymap.set("n", "<C-p>", find_files, { desc = "Find all files in git project" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "Search oldfiles" })

		-- finding text in files
		vim.keymap.set("n", "<leader>sw", grep_string, { desc = "Grep string" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Live grep" })
		vim.keymap.set("n", "<leader>s/", search_in_file, { desc = "[S]earch [/] in Open Files" })
		vim.keymap.set("n", "<leader>sn", search_in_neovim_config, { desc = "Search in neovim config" })

		-- telescope builtins
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search help tags" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search keymaps" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Search builtin" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search diagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Re-open last telescope picker" })
	end,
}

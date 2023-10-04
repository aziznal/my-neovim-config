return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
        local builtin = require("telescope.builtin")

        local function find_files()
            builtin.find_files {
                previewer = false,
                hidden = true,
                file_ignore_patterns = {"node_modules", "dist", "build", "target"}
            }
        end

        local function find_git_files()
            builtin.git_files {
                previewer = false,
                show_untracked = true
            }
        end

        local function list_buffers()
            builtin.buffers {
                sort_lastused = true,
                previewer = false,
                initial_mode = "normal",
                ignore_current_buffer = true
            }
        end

        vim.keymap.set("n", "<leader>pf", find_files, {})
        vim.keymap.set("n", "<C-p>", find_git_files, {})
        vim.keymap.set("n", "<C-Tab>", list_buffers, {})

        -- fuzzy file finding
        vim.keymap.set(
            "n",
            "<leader>ps",
            function()
                builtin.grep_string(
                    {
                        search = vim.fn.input("Grep > ")
                    }
                )
            end
        )

        -- live grep
        vim.keymap.set(
            "n",
            "<leader>pg",
            function()
                builtin.live_grep()
            end
        )

        -- file browser extension
        require("telescope").setup {
            extensions = {
                file_browser = {
                    initial_mode = "normal",
                    sorting_strategy = "ascending",
                    -- disables netrw and use telescope-file-browser in its place
                    -- hijack_netrw = true,
                    mappings = {
                        ["i"] = {},
                        ["n"] = {}
                    }
                }
            }
        }

        require("telescope").load_extension "file_browser"

        vim.api.nvim_set_keymap("n", "<space>fb", ":Telescope file_browser<CR>", {noremap = true})

        -- open file_browser with the path of the current buffer
        vim.api.nvim_set_keymap(
            "n",
            "<leader><C-e>",
            ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
            {noremap = true}
        )
    end
}

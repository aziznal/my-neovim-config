local builtin = require("telescope.builtin")

local function find_files()
    builtin.find_files {
        previewer = false,
        hidden = true
    }
end

local function find_git_files()
    builtin.git_files {previewer = false}
end

local function list_buffers()
    builtin.buffers {
        sort_lastused = true,
        previewer = false,
        initial_mode = "normal"
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
        builtin.grep_string({search = vim.fn.input("Grep > ")})
    end
)

-- recent projects (integration from project explorer plugin)
require("telescope").load_extension("projects")

local function show_recent_projects()
    require "telescope".extensions.projects.projects {}
end

vim.keymap.set("n", "<leader><C-r>", show_recent_projects)

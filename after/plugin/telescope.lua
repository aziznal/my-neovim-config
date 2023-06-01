local builtin = require('telescope.builtin')

local function find_files()
	builtin.find_files { previewer= false }
end

local function find_git_files()
	builtin.git_files { previewer= false }
end

vim.keymap.set('n', '<leader>pf', find_files , {})
vim.keymap.set('n', '<C-p>', find_git_files , {})

-- fuzzy file finding
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- recent projects (integration from project explorer plugin)
require('telescope').load_extension('projects')

vim.keymap.set('n', '<leader><C-r>', function() require'telescope'.extensions.projects.projects{} end)

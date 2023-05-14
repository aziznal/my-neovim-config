local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- fuzzy file finding
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)


-- recent projects (integration from project explorer plugin)
require('telescope').load_extension('projects')

vim.keymap.set('n', '<leader><C-r>', function() require'telescope'.extensions.projects.projects{} end)

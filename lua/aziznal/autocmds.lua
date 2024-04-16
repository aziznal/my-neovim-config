-- [[ highlight yanked group ]]
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- [[ remember folds ]]
vim.opt.viewoptions:remove("options") -- not sure why this line is necessary
vim.api.nvim_create_augroup("remember_folds", {})
vim.api.nvim_clear_autocmds({ group = "remember_folds" })

-- save folds when leaving buffers, unless it's a 'help' filetype
vim.api.nvim_create_autocmd("BufWinLeave", {
	group = "remember_folds",
	pattern = "*.*",
	command = 'if &ft !=# "help" | mkview | endif',
})

-- load folds when entering buffers, unless it's a 'help' filetype
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = "remember_folds",
	pattern = "*.*",
	command = 'if &ft !=# "help" | silent! loadview | endif',
})

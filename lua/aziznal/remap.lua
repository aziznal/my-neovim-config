-- change leader key to space
vim.g.mapleader = " "

-- map explorer command to make it easier to open
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- center screen when jumping half a page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
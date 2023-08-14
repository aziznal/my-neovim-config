-- change leader key to space
vim.g.mapleader = " "

-- map explorer command to make it easier to open (disabled because I use nvim-tree)
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- moving selection up and down (intelligently)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor in center:
--  while jumping half pages
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

--  while finding next/previous matches
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

--  while using *, #
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")

--  while jumping to mark

-- better replace: doesn't overwrite your copy buffer when you use it
vim.keymap.set("x", "<leader>p", '"_dP')

-- ability to copy to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- ability to delete line without copying
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- move between splits more easily
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- resize panes more easily
vim.keymap.set("n", "<C-Left>", ":vertical resize +3<CR>", {silent = true, noremap = true})
vim.keymap.set("n", "<C-Right>", ":vertical resize -3<CR>", {silent = true, noremap = true})
vim.keymap.set("n", "<C-Up>", ":resize +3<CR>", {silent = true, noremap = true})
vim.keymap.set("n", "<C-Down>", ":resize -3<CR>", {silent = true, noremap = true})

-- Set esc to jj
vim.keymap.set("i", "jj", "<ESC>")

-- set leader leader h to toggle search highlight
vim.keymap.set("n", "<leader><leader>h", ":nohlsearch<CR>", {silent = true, noremap = true})

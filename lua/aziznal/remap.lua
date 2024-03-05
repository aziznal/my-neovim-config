-- change leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- moving selection up and down (intelligently)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--  center cursor when jumping half pages
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- center cursor while finding next/previous matches
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- center cursor while using *, #
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")

-- shortcuts for yanking to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- deleting to void register
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

-- toggle search highlight
vim.keymap.set("n", "<leader><leader>h", ":nohlsearch<CR>", {silent = true, noremap = true})

-- exiting insert while in terminal mode is a bit weird by default
vim.keymap.set("t", "jj", "<C-\\><C-n>")


-- change leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- moving selection up and down (intelligently)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--  center screen when jumping half pages
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- center screen while finding next/previous matches
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- center screen while using *, #
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")

-- quick write
vim.keymap.set("n", "<leader>w", ":w<CR>")

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
vim.keymap.set("n", "<C-Left>", ":vertical resize +3<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-Right>", ":vertical resize -3<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-Up>", ":resize +3<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-Down>", ":resize -3<CR>", { silent = true, noremap = true })

-- Set esc to jj
vim.keymap.set("i", "jj", "<ESC>")

-- toggle search highlight
vim.keymap.set("n", "<leader><leader>h", ":nohlsearch<CR>", { silent = true, noremap = true })

-- exiting insert while in terminal mode is a bit weird by default
vim.keymap.set("t", "jj", "<C-\\><C-n>")

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })

-- [[ quickfix list shortcuts ]]

-- 1. open / close
vim.keymap.set("n", "<leader>co", ":copen<CR>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>cc", ":cclose<CR>", { desc = "Open quickfix list" })

-- 2. next and prev items
vim.keymap.set("n", "<leader>;", ":cnext<CR>", { desc = "go to next quickfix item" })
vim.keymap.set("n", "<leader>,", ":cprevious<CR>", { desc = "go to previous quickfix item" })

--[[ my custom macros ]]

-- 1. escape html
vim.keymap.set("n", "<leader>cme", "diwi{`<Esc>pa`}<Esc>", { desc = "Escape html" })

-- 2. convert className to use cn util
vim.keymap.set("n", "<leader>cmcn", 'da"i{cn(<Esc>pa)}<Esc>', { desc = 'Convert className="" to className={cn(...)}' })

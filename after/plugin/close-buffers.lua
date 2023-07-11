require("close_buffers").setup({})

-- Commands:
-- :Bdelete this | other | all | hidden | modified
-- add bang (!) to force delete

local map = vim.keymap.set
local opts = {noremap = true, silent = true}

map("n", "<leader>x", ":BDelete this<CR>", opts)
map("n", "<leader>X", ":BDelete other<CR>", opts)
map("n", "<leader>Z", ":BDelete all<CR>", opts)

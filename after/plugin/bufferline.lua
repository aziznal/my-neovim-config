-- termguicolors already set in sets.lua

local bufferline = require("bufferline")

bufferline.setup {
    options = {
        style_preset = {
            bufferline.style_preset.no_italic,
            bufferline.style_preset.no_bold
        },
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
        separator_style = "thick",
        indicator = {
            style = "icon",
            icon = "🍉"
        },
        modified_icon = "🟡",
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                separator = true -- use a "true" to enable the default, or set your own character
            }
        }
    }
}

-- Keybindings
local map = vim.keymap.set
local opts = {noremap = true, silent = true}

map("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", opts)
map("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", opts)
map("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", opts)
map("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", opts)
map("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", opts)
map("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", opts)
map("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", opts)
map("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", opts)
map("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", opts)
map("n", "<leader>$", ":BufferLineGoToBuffer -1<CR>", opts)

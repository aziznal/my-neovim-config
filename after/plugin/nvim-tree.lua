-- disable netrw to avoid conflicts
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Main Shortcuts:
-- <leader><C-e> - toggle tree with current file selected
-- a - create a file or directory
-- d - remove a file or directory
-- r - rename a file or directory

-- <CR> - expand dir / open file
-- W - collapse
-- E - expand recursively
--
-- <C-v> - split
-- <C-x> - vsplit

require("nvim-tree").setup {
    sort_by = "case_sensitive",
    view = {
        width = 40,
    },
    filters = {
        dotfiles = false
    },
    renderer = {
        highlight_opened_files = "name",
        highlight_modified = "name"
    },
    git = {
        enable = true,
        ignore = false
    }
}

vim.keymap.set("n", "<leader><C-e>", ":NvimTreeFindFileToggle<CR>", {noremap = true, silent = true})

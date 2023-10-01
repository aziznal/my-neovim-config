return {
    "mrbjarksen/neo-tree-diagnostics.nvim",
    dependencies = {"nvim-neo-tree/neo-tree.nvim"},
    config = function()
        vim.keymap.set(
            "n",
            "<leader><C-d>",
            ":Neotree diagnostics reveal bottom<CR>",
            {
                noremap = true,
                silent = true
            }
        )
    end
}

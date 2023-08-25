return {
    "folke/which-key.nvim",
    event = "BufRead",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 1000
        require("which-key").setup {}
    end
}

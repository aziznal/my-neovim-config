-- toggle comments in code
return {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
        require("Comment").setup()

        -- Basic Mappings
        -- `gcc` - Toggles the current line using linewise comment
        -- `gbc` - Toggles the current line using blockwise comment
        -- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
        -- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
        -- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
        -- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
    end
}

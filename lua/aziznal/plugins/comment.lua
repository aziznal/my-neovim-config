-- toggle comments in code
return {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
        require("Comment").setup {
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
        }

        -- Basic Mappings
        -- `gcc` - Toggles the current line using linewise comment
        -- `gbc` - Toggles the current line using blockwise comment
        -- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
        -- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
        -- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
        -- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
    end
}

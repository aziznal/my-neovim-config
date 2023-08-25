-- for showing lsp load progress
return {
    "j-hui/fidget.nvim",
    tag = "legacy",
    config = function()
        require("fidget").setup {}
    end
}


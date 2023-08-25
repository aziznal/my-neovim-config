-- shows a little light bulb when a code action is available
return {
    "kosayoda/nvim-lightbulb",
    config = function()
        require("nvim-lightbulb").setup({
            autocmd = {
                enabled = true,
                updateTime = 50
            },
            priority = 100,
            sign = {
                enabled = true
            }
        })
    end
}

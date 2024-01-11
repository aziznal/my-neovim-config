-- .kbd file support
return {
    "kmonad/kmonad-vim",
    filetype = "kbd",
    config = function()
        require("nvim-lightbulb").setup()
    end
}

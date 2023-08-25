-- add highlight matching color to color codes (hex, rgb, etc.)
return {
    "RRethy/vim-hexokinase",
    build = "make hexokinase",
    config = function()
        vim.cmd("let g:Hexokinase_highlighters = ['virtual']")

        vim.cmd(
            "let g:Hexokinase_optInPatterns = ['full_hex', 'triple_hex', 'rgb', 'rgba', 'hsl', 'hsla', 'colour_names']")
    end
}

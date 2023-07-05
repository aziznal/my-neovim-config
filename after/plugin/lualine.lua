require("lualine").setup(
    {
        options = {
            theme = "catppuccin",
            section_separators = {left = "", right = ""},
            component_separators = {left = "", right = ""}
        },
        icons_enabled = true,
        sections = {
            lualine_a = {"mode"},
            lualine_b = {""},
            lualine_c = {"filename"},
            lualine_x = {"filetype"},
            lualine_y = {"branch"},
            lualine_z = {""}
        },
        tabline = {},
        globalstatus = true
    }
)

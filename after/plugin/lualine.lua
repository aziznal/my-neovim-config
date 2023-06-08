require("lualine").setup(
    {
        options = {
            theme = require("lualine.themes.material")
        },
        icons_enabled = true,
        sections = {
            lualine_a = {"mode"},
            lualine_b = {"branch"},
            lualine_c = {"filename"},
            lualine_x = {"searchcount", "fileformat", "filetype"},
            lualine_y = {"progress"},
            lualine_z = {"location"}
        },
        tabline = {},
        globalstatus = false
    }
)

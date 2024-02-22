return {
    "rcarriga/nvim-notify",
    config = function()
        require("notify").setup(
            {
                stages = "fade",
                timeout = 3000,
                fps = 60,
                background_colour = "#000000",
                icons = {
                    ERROR = "",
                    WARN = "",
                    INFO = "",
                    DEBUG = "",
                    TRACE = "✎"
                }
            }
        )
    end
}

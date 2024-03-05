return {
    "zbirenbaum/copilot.lua",
    event = "BufRead",
    config = function()
        require("copilot").setup(
            {
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    keymap = {
                        accept = "<C-a>"
                    }
                }
            }
        )
    end
}

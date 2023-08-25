return {
    "saecki/crates.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
        local crates = require("crates");

        crates.setup();
        crates.show();

    end
}

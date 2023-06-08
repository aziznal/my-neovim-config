local function formatWithPrettier()
    return {
        -- must have prettierd for this to work. install via `npm install -g @fsouza/prettierd`
        exe = "prettierd",
        args = {vim.api.nvim_buf_get_name(0)},
        stdin = true
    }
end

require("formatter").setup {
    filetype = {
        -- must have luafmt for this to work. install via `npm install -g lua-fmt`
        lua = {
            function()
                return {
                    exe = "luafmt",
                    args = {"--indent-count", 4, "--stdin"},
                    stdin = true
                }
            end
        },
        typescript = {
            formatWithPrettier
        },
        typescriptreact = {
            formatWithPrettier
        },
        javascript = {
            formatWithPrettier
        },
        javascriptreact = {
            formatWithPrettier
        },
        html = {
            formatWithPrettier
        },
        css = {
            formatWithPrettier
        },
        json = {
            formatWithPrettier
        },
        markdown = {
            formatWithPrettier
        },
        yaml = {
            formatWithPrettier
        }
    }
}

-- leader f to format
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>FormatWrite<CR>", {noremap = true, silent = true})

local function formatWithPrettier()
    return {
        -- must have prettierd for this to work. install via `npm install -g @fsouza/prettierd`
        exe = "prettierd",
        args = {vim.api.nvim_buf_get_name(0)},
        stdin = true
    }
end

-- format lua
local function formatLuaWithLuafmt()
    return {
        exe = "luafmt",
        args = {"--indent-count", 4, "--stdin"},
        stdin = true
    }
end

require("formatter").setup {
    filetype = {
        -- must have luafmt for this to work. install via `npm install -g lua-fmt`
        lua = {
            formatLuaWithLuafmt
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
        scss = {
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

-- Format on save
vim.api.nvim_exec(
    [[
        augroup FormatAutogroup
            autocmd!
            autocmd BufWritePost * FormatWrite
        augroup END
    ]],
    true
)

-- leader f to format
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>Format<CR>", {noremap = true, silent = true})

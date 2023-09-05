return {
    "mhartington/formatter.nvim",
    event = "BufRead",
    config = function()
        local function formatWithPrettier()
            local bufferName = vim.api.nvim_buf_get_name(0)

            -- surround buffer name with double quotes
            -- this helps with paths that contain weird shit like parentheses, etc..
            bufferName = '"' .. bufferName .. '"'

            return {
                -- must have prettierd for this to work. install via `npm install -g @fsouza/prettierd`
                exe = "prettierd",
                args = {bufferName},
                stdin = true
            }
        end

        local function formatWithGofmt()
            return {
                exe = "gofmt",
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

        local function formatRustWithRustFmt()
            vim.cmd("RustFmt")
        end

        require("formatter").setup {
            filetype = {
                -- must have luafmt for this to work. install via `npm install -g lua-fmt`
                lua = {formatLuaWithLuafmt},
                typescript = {formatWithPrettier},
                typescriptreact = {formatWithPrettier},
                javascript = {formatWithPrettier},
                javascriptreact = {formatWithPrettier},
                html = {formatWithPrettier},
                css = {formatWithPrettier},
                scss = {formatWithPrettier},
                json = {formatWithPrettier},
                markdown = {formatWithPrettier},
                yaml = {formatWithPrettier},
                rust = {formatRustWithRustFmt},
                go = {formatWithGofmt}
            }
        }

        -- Format on save (disabled cuz it gets on my f@cking nerves with tailwind)
        -- vim.api.nvim_exec(
        --     [[
        --         augroup FormatAutogroup
        --             autocmd!
        --             autocmd BufWritePost * FormatWrite
        --         augroup END
        --     ]],
        --     true
        -- )

        -- leader f to format
        vim.api.nvim_set_keymap(
            "n",
            "<leader>f",
            "<cmd>Format<CR>",
            {
                noremap = true,
                silent = true
            }
        )
    end
}

-- https://github.com/stevearc/conform.nvim
return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      notify_on_error = false,

      formatters_by_ft = {
        lua = { "stylua", stop_after_first = true },
        css = { "prettierd", stop_after_first = true },
        html = { "prettierd", stop_after_first = true },

        javascript = { "prettierd", stop_after_first = true, timeout_ms = 2000 },
        javascriptreact = { "prettierd", stop_after_first = true, timeout_ms = 2000 },
        typescript = { "prettierd", stop_after_first = true, timeout_ms = 2000 },
        typescriptreact = { "prettierd", stop_after_first = true, timeout_ms = 2000 },

        markdown = { "prettierd", stop_after_first = true },
        json = { "prettierd", stop_after_first = true },
        jsonc = { "prettierd", stop_after_first = true },
        go = { "gofmt", stop_after_first = true },

        rust = { "rustfmt", stop_after_first = true },

        sql = { "pg_format", stop_after_first = true },
      },
    })

    -- format shortcut
    vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua require('conform').format()<CR>", {
      noremap = true,
      silent = true,
      desc = "Format with Conform",
    })
  end,
}

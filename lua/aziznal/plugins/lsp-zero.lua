return {
	-- "VonHeikemen/lsp-zero.nvim",
	-- branch = "v2.x",
	-- dependencies = {
	--     {"neovim/nvim-lspconfig"},
	--     {"williamboman/mason.nvim"},
	--     {"williamboman/mason-lspconfig.nvim"},
	--     {"hrsh7th/nvim-cmp"},
	--     {"hrsh7th/cmp-nvim-lsp"},
	--     {"saadparwaiz1/cmp_luasnip"},
	--     {"L3MON4D3/LuaSnip"}
	-- },
	-- config = function()
	--     local lsp = require("lsp-zero")
	--
	--     lsp.preset("recommended")
	--
	--     lsp.ensure_installed({"tsserver"})
	--
	--     -- navigating completions
	--     -- local cmp = require("cmp")
	--
	--     -- cmp.setup(
	--     --     {
	--     --         snippet = {
	--     --             expand = function(args)
	--     --                 require("luasnip").lsp_expand(args.body)
	--     --             end
	--     --         },
	--     --         mapping = {
	--     --             ["<C-p>"] = cmp.mapping.select_prev_item(),
	--     --             ["<C-n>"] = cmp.mapping.select_next_item(),
	--     --             ["<C-y>"] = cmp.mapping.confirm(
	--     --                 {
	--     --                     select = true
	--     --                 }
	--     --             ),
	--     --             ["<C-Space>"] = cmp.mapping.complete()
	--     --         },
	--     --         sources = {
	--     --             {name = "nvim_lsp"},
	--     --             {name = "luasnip"}
	--     --         }
	--     --     }
	--     -- )
	--
	--     lsp.on_attach(
	--         function(client, bufnr)
	--             local opts = {
	--                 buffer = bufnr,
	--                 remap = false
	--             }
	--
	--             vim.keymap.set(
	--                 "n",
	--                 "gd",
	--                 function()
	--                     vim.lsp.buf.definition()
	--                 end,
	--                 opts
	--             )
	--             vim.keymap.set(
	--                 "n",
	--                 "K",
	--                 function()
	--                     vim.lsp.buf.hover()
	--                 end,
	--                 opts
	--             )
	--             vim.keymap.set(
	--                 "n",
	--                 "<leader>vws",
	--                 function()
	--                     vim.lsp.buf.workspace_symbol()
	--                 end,
	--                 opts
	--             )
	--             vim.keymap.set(
	--                 "n",
	--                 "<leader>vd",
	--                 function()
	--                     vim.diagnostic.open_float()
	--                 end,
	--                 opts
	--             )
	--             vim.keymap.set(
	--                 "n",
	--                 "]d",
	--                 function()
	--                     vim.diagnostic.goto_next()
	--                 end,
	--                 opts
	--             )
	--             vim.keymap.set(
	--                 "n",
	--                 "[d",
	--                 function()
	--                     vim.diagnostic.goto_prev()
	--                 end,
	--                 opts
	--             )
	--             vim.keymap.set(
	--                 "n",
	--                 "<leader>vca",
	--                 function()
	--                     vim.lsp.buf.code_action()
	--                 end,
	--                 opts
	--             )
	--             vim.keymap.set(
	--                 "n",
	--                 "<leader>vrr",
	--                 function()
	--                     vim.lsp.buf.references()
	--                 end,
	--                 opts
	--             )
	--             vim.keymap.set(
	--                 "n",
	--                 "<leader>vrn",
	--                 function()
	--                     vim.lsp.buf.rename()
	--                 end,
	--                 opts
	--             )
	--             vim.keymap.set(
	--                 "i",
	--                 "<C-h>",
	--                 function()
	--                     vim.lsp.buf.signature_help()
	--                 end,
	--                 opts
	--             )
	--             -- keymap to restart lsp since some like to crash
	--             vim.keymap.set(
	--                 "n",
	--                 "<leader><leader>r",
	--                 function()
	--                     vim.cmd("LspRestart")
	--                 end,
	--                 opts
	--             )
	--         end
	--     )
	--
	--     -- lua ls config
	--     require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
	--
	--     -- -- angular ls setup
	--     -- require("lspconfig").angularls.setup {
	--     --     root_dir = require("lspconfig/util").root_pattern("project.json", "angular.json")
	--     -- }
	--
	--     -- tailwind css setup
	--     require("lspconfig").tailwindcss.setup {}
	--
	--     -- rust
	--     -- require("lspconfig").rust_analyzer.setup {
	--     --     on_attach = lsp.on_attach,
	--     --     capabilities = lsp.capabilities,
	--     --     -- below cmd field necessary when running rust-analyzer via rustup
	--     --     cmd = {"rustup", "run", "stable", "rust-analyzer"},
	--     --     settings = {
	--     --         ["rust-analyzer"] = {
	--     --             cargo = {
	--     --                 allFeatures = true
	--     --             },
	--     --             diagnostics = {
	--     --                 enable = true,
	--     --                 experimental = {
	--     --                     enable = true
	--     --                 }
	--     --             }
	--     --         }
	--     --     }
	--     -- }
	--     --
	--     lsp.setup()
	-- end
}

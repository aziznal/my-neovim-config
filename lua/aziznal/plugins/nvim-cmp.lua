return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      "L3MON4D3/LuaSnip",
      build = (function()
        -- Build Step is needed for regex support in snippets
        -- This step is not supported in many windows environments
        -- Remove the below condition to re-enable on windows
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end

        return "make install_jsregexp"
      end)(),
    },
    "saadparwaiz1/cmp_luasnip",
    -- Adds other completion capabilities.
    --  nvim-cmp does not ship with all sources by default. They are split
    --  into multiple repos for maintenance purposes.
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",

    -- If you want to add a bunch of pre-configured snippets,
    --    you can use this plugin to help you. It even has snippets
    --    for various frameworks/libraries/etc. but you will have to
    --    set up the ones that are useful for you.
    -- 'rafamadriz/friendly-snippets',
  },
  config = function()
    -- See `:help cmp`
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    local luasnip = require("luasnip")
    luasnip.setup()

    vim.keymap.set({ "i", "s" }, "<C-E>", function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end, { silent = true })

    require("aziznal.snippets.typescript")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = "menu,menuone,noinsert" },
      mapping = cmp.mapping.preset.insert({
        -- Select the [n]ext item
        ["<C-n>"] = cmp.mapping.select_next_item(),
        -- Select the [p]revious item
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        -- Accept ([y]es) the completion.
        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        -- Manually trigger a completion from nvim-cmp.
        --  Generally you don't need this, because nvim-cmp will display
        --  completions whenever it has completion options available.
        ["<C-Space>"] = cmp.mapping.complete({}),
        -- Think of <c-l> as moving to the right of your snippet expansion.
        --  So if you have a snippet that's like:
        --  function $name($args)
        --    $body
        --  end
        --
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ["<C-l>"] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "lspkind" },
      },
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol", -- Show only the icon, hide "Method/Function" text
          maxwidth = 50,
          ellipsis_char = "...",
          before = function(entry, vim_item)
            local item = entry.completion_item

            -- show import path
            if item.data and item.data.entryNames and item.data.entryNames[1] then
              local source = item.data.entryNames[1].source
              if source then
                vim_item.menu = source
              end
            end

            return vim_item
          end,
        }),
      },
    })
  end,
}

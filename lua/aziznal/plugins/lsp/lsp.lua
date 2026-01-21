return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "j-hui/fidget.nvim", opts = {} },
    { "folke/lazydev.nvim", opts = {} },
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- add autocomplete
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    vim.lsp.config("*", {
      capabilities = capabilities,
    })
  end,
}

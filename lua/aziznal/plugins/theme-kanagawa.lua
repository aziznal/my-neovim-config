return {
  "rebelot/kanagawa.nvim",
  enabled = true,
  -- high priority to make sure theme is loaded first
  priority = 1000,
  config = function()
    vim.cmd("colorscheme kanagawa")
  end,
}

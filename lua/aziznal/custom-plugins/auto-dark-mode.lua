-- Follow the macOS light/dark appearance at runtime: flip &background and
-- re-apply the active colorscheme (works for any background-aware theme).
-- ghostty doesn't notify running apps on OS theme change, so we poll
-- AppleInterfaceStyle and also re-check on refocus. macOS-only; inert elsewhere.

if vim.fn.has("mac") ~= 1 then
  return
end

local function syncBackground()
  vim.system(
    { "defaults", "read", "-g", "AppleInterfaceStyle" },
    { text = true },
    vim.schedule_wrap(function(out)
      local bg = (out.code == 0 and out.stdout:match("Dark")) and "dark" or "light"

      if vim.o.background == bg then
        return
      end

      vim.o.background = bg

      if vim.g.colors_name then
        vim.cmd("colorscheme " .. vim.g.colors_name)
      end
    end)
  )
end

syncBackground()

local timer = vim.uv.new_timer()
timer:start(2000, 2000, vim.schedule_wrap(syncBackground))

vim.api.nvim_create_autocmd("FocusGained", { callback = syncBackground })

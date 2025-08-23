local qf_file = vim.fn.stdpath("data") .. "/qf_list.vim"

-- Save quickfix on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    local qf = vim.fn.getqflist({ all = 1 }).items
    local lines = {}

    for _, item in ipairs(qf) do
      -- Convert bufnr → filename otherwise it fails on load later
      local fname = ""

      if item.bufnr and item.bufnr > 0 then
        fname = vim.fn.bufname(item.bufnr)
      end

      table.insert(
        lines,
        vim.inspect({
          filename = fname,
          lnum = item.lnum,
          col = item.col,
          text = item.text,
          type = item.type,
        })
      )
    end

    vim.fn.writefile(lines, qf_file)
  end,
})

-- Restore quickfix on start
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.filereadable(qf_file) == 1 then
      local lines = vim.fn.readfile(qf_file)
      local list = {}

      for _, l in ipairs(lines) do
        local ok, val = pcall(load("return " .. l))
        if ok and val and val.filename ~= "" then
          table.insert(list, val)
        end
      end

      if #list > 0 then
        vim.fn.setqflist({}, "r", { items = list })
      end
    end
  end,
})

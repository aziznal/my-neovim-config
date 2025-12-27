-- [[
--		Runs the command `tsgo --noEmit --pretty true` and parses the summary lines
--    at the end into the quickfix list (one entry per file) using Lua patterns.
--    Handles single-file, multi-file, and multi-error-same-file summary formats.
--
--    install tsgo with `npm i -g @typescript/native-preview`
--
--		(Some of this code is) Shamefully vibe-coded with the help of gemini-2.5pro (in like 15 iterations)
-- ]]

---@diagnostic disable: missing-fields
---@diagnostic disable: unused-local

---@class TscQuickFixItem : vim.quickfix.entry
-- Represents a single entry in the quickfix list, pointing to a file from the TSC summary.

---@class TscQuickFixModule
---@field run_tsc_check fun():nil
local M = {}

--- Strips ANSI escape codes from a string.
---@param str string The input string potentially containing ANSI codes.
---@return string str_clean The string with ANSI codes removed.
local function strip_ansi(str)
  -- Pattern matches ANSI escape sequences: ESC [ ... m
  local clean_str = string.gsub(str, "\x1b%[[%d;]*[a-zA-Z]", "")
  return clean_str
end

--- Parses the summary lines from `tsc --pretty true` output using Lua patterns.
--- Handles:
---   1. "Found 1 error in file:line"
---   2. "Found N errors in the same file, starting at: file:line"
---   3. Multi-file detail lines ("     N  file:line")
---@param tsc_output_lines string[] Full output from the tsc command.
---@return TscQuickFixItem[] qf_list A table of quickfix item tables (one per file).
local function parse_tsc_summary(tsc_output_lines)
  ---@type TscQuickFixItem[]
  local qf_list = {}
  ---@type table<string, boolean> Keep track of files already added
  local added_files = {}

  -- Pattern 1: Single error, single file
  local single_error_pattern = "^Found 1 error in (.*):(%d+)$"
  -- Pattern 2: Multiple errors, single file
  local multi_error_same_file_pattern = "^Found %d+ errors in the same file, starting at: (.*):(%d+)$"
  -- Pattern 3: Multi-file summary detail lines
  local multi_file_detail_pattern = "^%s*%d+%s+(.*):(%d+)$"

  for _, original_line in ipairs(tsc_output_lines) do
    local line = strip_ansi(original_line)
    local filename, lnum_str = nil, nil -- Initialize captures

    -- Try matching patterns in order
    filename, lnum_str = string.match(line, single_error_pattern)

    if not filename then
      filename, lnum_str = string.match(line, multi_error_same_file_pattern)
    end

    if not filename then
      filename, lnum_str = string.match(line, multi_file_detail_pattern)
    end

    -- Check if any match was successful
    if filename and lnum_str then
      local lnum = tonumber(lnum_str)
      filename = vim.fn.trim(filename) -- Trim whitespace

      -- Add only one entry per file
      if lnum and filename ~= "" and not added_files[filename] then
        -- Validate file path relative to CWD
        if vim.fn.filereadable(filename) == 1 or vim.fn.isdirectory(filename) == 0 then
          table.insert(qf_list, {
            filename = filename,
            lnum = lnum,
            text = line, -- Use the cleaned summary line as text
            type = "E",
          })
          added_files[filename] = true
        end
      end
    end
  end
  return qf_list
end

--- Runs 'tsgo --noEmit --pretty true', parses the summary output,
--- and populates the quickfix list with one entry per file.
---@nodiscard Does not return a value, operates via side effects (job, quickfix).
function M.run_tsc_check()
  ---@type string[]
  local output_lines = {}

  local job_options = {
    stdout_buffered = true,
    stderr_buffered = true,
    ---@param _job_id number The job id.
    ---@param data string[]|nil Table of stdout lines or nil if channel closed.
    ---@param _event string The event name ('stdout').
    on_stdout = function(_job_id, data, _event)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(output_lines, line)
          end
        end
      end
    end,
    ---@param _job_id number The job id.
    ---@param data string[]|nil Table of stderr lines or nil if channel closed.
    ---@param _event string The event name ('stderr').
    on_stderr = function(_job_id, data, _event)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(output_lines, line)
          end
        end
      end
    end,
    ---@param _job_id number The job id.
    ---@param code number The exit code of the process.
    ---@param _event string The event name ('exit').
    on_exit = function(_job_id, code, _event)
      ---@type TscQuickFixItem[]
      local qf_list = parse_tsc_summary(output_lines)

      if #qf_list > 0 then
        vim.fn.setqflist({}, " ", { title = "TSC File Errors (Summary)", items = qf_list })
        vim.cmd("copen")
        vim.notify("TSC check finished. Found errors in " .. #qf_list .. " file(s).", vim.log.levels.INFO)
      elseif code == 0 then
        vim.fn.setqflist({}, "r", { title = "TSC File Errors (Summary)", items = {} })
        vim.cmd("cclose")
        vim.notify("TSC check finished. No errors found.", vim.log.levels.INFO)
      elseif code ~= 0 and #qf_list == 0 then
        vim.fn.setqflist({}, "r", { title = "TSC File Errors (Summary)", items = {} })
        vim.cmd("cclose")
        vim.notify("TSC check failed or produced no parsable summary lines. Exit code: " .. code, vim.log.levels.WARN)
        vim.notify("--- Raw TSC Output Start (Failure Case) ---", vim.log.levels.INFO)
        for i, line in ipairs(output_lines) do
          vim.notify(string.format("[%d]: %s", i, line), vim.log.levels.INFO)
        end
        vim.notify("--- Raw TSC Output End (Failure Case) ---", vim.log.levels.INFO)
      end
    end,
  }

  ---@type number|nil job_id The started job's ID or nil on failure.
  local job_id = vim.fn.jobstart({ "tsgo", "--pretty", "true" }, job_options)

  if not job_id or job_id == 0 or job_id == -1 then
    vim.notify("Failed to start tsgo job.", vim.log.levels.ERROR)
    return
  end

  vim.notify("Running tsgo --noEmit --pretty true...", vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("TscCheck", M.run_tsc_check, {
  nargs = 0,
  desc = "Run tsgo --pretty true, books_books_list files with errors in quickfix",
  force = true,
books_books_})

return M

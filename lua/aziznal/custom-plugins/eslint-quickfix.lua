-- [[
--    Runs `pnpm lint:check` (ESLint) and parses output into the quickfix list.
--    Handles common ESLint formats:
--      - "stylish" (default): file header lines + "  line:col  level  message  rule"
--      - "unix": "path:line:col: level message [rule]"
--
--    Assumptions:
--      - Your pnpm script `lint:check` prints ESLint results using either
--        the default "stylish" or "unix" formatter.
--      - Lines can contain ANSI color; we strip those.
--
--    Create command :EslintCheck to run it.
-- ]]

---@diagnostic disable: missing-fields
---@diagnostic disable: unused-local

---@class EslintQuickFixItem : vim.quickfix.entry
-- Represents a single ESLint issue entry for the quickfix list.

---@class EslintQuickFixModule
---@field run_eslint_check fun():nil
local M = {}

--- Strip ANSI escape codes from a string.
---@param str string
---@return string
local function strip_ansi(str)
  return (string.gsub(str, "\x1b%[[%d;]*[A-Za-z]", ""))
end

--- Map ESLint severity -> quickfix type.
---@param level string
---@return string
local function severity_to_type(level)
  local s = string.lower(level or "")
  if s == "error" then
    return "E"
  elseif s == "warning" or s == "warn" then
    return "W"
  else
    return "I"
  end
end

--- Detects if a line is a file header line (for "stylish" formatter).
---@param line string
---@return string|nil
local function parse_file_header(line)
  if line == "" then
    return nil
  end
  if line:match("^%s*%d+:%d+") then
    return nil
  end
  if
    line:match("^✖")
    or line:match("^✔")
    or line:match("^%s*%d+ problem")
    or line:match("^%s*%d+ error")
    or line:match("^%s*%d+ warning")
  then
    return nil
  end

  -- Windows absolute path: C:\...
  if line:match("^[A-Za-z]:[\\/].+") then
    return vim.fn.trim(line)
  end
  -- Unix absolute path: /...
  if line:match("^/.*") then
    return vim.fn.trim(line)
  end
  -- Relative path with extension (no leading whitespace)
  if line:match("^[^%s].+%.[%w]+$") then
    return vim.fn.trim(line)
  end

  return nil
end

--- Try parsing a single "unix" formatter line:
---   path:line:col: level message [rule]
--- Works with both Unix and Windows paths.
---@param line string
---@return EslintQuickFixItem|nil
local function parse_unix_line(line)
  -- Windows path first (e.g., C:\dir\file.ts:3:5: error msg [rule])
  local path, lnum, col, level, rest = line:match("^([A-Za-z]:[\\/].-):(%d+):(%d+):%s+([%a]+)%s+(.+)$")

  if not path then
    -- Generic (Unix/relative): path:line:col: level msg [rule]
    path, lnum, col, level, rest = line:match("^(.-):(%d+):(%d+):%s+([%a]+)%s+(.+)$")
  end

  if not path then
    return nil
  end

  local message, rule = rest:match("^(.-)%s+%[([%w-]+)%]%s*$")
  if not message then
    message = vim.fn.trim(rest)
  end

  return {
    filename = vim.fn.trim(path),
    lnum = tonumber(lnum) or 1,
    col = tonumber(col) or 1,
    text = rule and (message .. " [" .. rule .. "]") or message,
    type = severity_to_type(level),
  }
end

--- Try parsing a "stylish" detail line:
---   "  line:col  level  message  rule"
---@param line string
---@param current_file string|nil
---@return EslintQuickFixItem|nil
local function parse_stylish_detail(line, current_file)
  if not current_file then
    return nil
  end

  local lnum, col, level, rest = line:match("^%s*(%d+):(%d+)%s+([%a]+)%s+(.+)$")
  if not lnum then
    return nil
  end

  -- Split message and rule by two+ spaces at the end
  local message, rule = rest:match("^(.-)%s%s+([%w-]+)%s*$")
  if not message then
    message = vim.fn.trim(rest)
  end

  return {
    filename = current_file,
    lnum = tonumber(lnum) or 1,
    col = tonumber(col) or 1,
    text = rule and (message .. " [" .. rule .. "]") or message,
    type = severity_to_type(level),
  }
end

--- Parse ESLint output lines into quickfix items.
--- Supports both "stylish" and "unix" ESLint format outputs.
---@param eslint_output_lines string[]
---@return EslintQuickFixItem[]
local function parse_eslint_output(eslint_output_lines)
  ---@type EslintQuickFixItem[]
  local qf_list = {}
  local current_file = nil

  for _, raw in ipairs(eslint_output_lines) do
    local line = strip_ansi(raw or "")
    if line == "" then
      goto continue
    end

    -- Try "unix" single-line entries first
    local unix_item = parse_unix_line(line)
    if unix_item then
      table.insert(qf_list, unix_item)
      goto continue
    end

    -- Try "stylish" header
    local header = parse_file_header(line)
    if header then
      current_file = header
      goto continue
    end

    -- Try "stylish" detail lines (requires current_file)
    local stylish_item = parse_stylish_detail(line, current_file)
    if stylish_item then
      table.insert(qf_list, stylish_item)
      goto continue
    end

    ::continue::
  end

  return qf_list
end

--- Runs 'pnpm lint:check', parses output, and populates quickfix.
function M.run_eslint_check()
  ---@type string[]
  local output_lines = {}

  local job_options = {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_job_id, data, _event)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(output_lines, line)
          end
        end
      end
    end,
    on_stderr = function(_job_id, data, _event)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(output_lines, line)
          end
        end
      end
    end,
    on_exit = function(_job_id, code, _event)
      ---@type EslintQuickFixItem[]
      local qf_list = parse_eslint_output(output_lines)

      if #qf_list > 0 then
        vim.fn.setqflist({}, " ", {
          title = "ESLint Issues",
          items = qf_list,
        })
        vim.cmd("copen")
        vim.notify("ESLint finished. Found " .. #qf_list .. " issue(s).", vim.log.levels.INFO)
      elseif code == 0 then
        vim.fn.setqflist({}, "r", { title = "ESLint Issues", items = {} })
        vim.cmd("cclose")
        vim.notify("ESLint finished. No issues found.", vim.log.levels.INFO)
      else
        vim.fn.setqflist({}, "r", { title = "ESLint Issues", items = {} })
        vim.cmd("cclose")
        vim.notify("ESLint failed or produced no parsable lines. Exit code: " .. code, vim.log.levels.WARN)
        vim.notify("--- Raw ESLint Output Start ---", vim.log.levels.INFO)
        for i, line in ipairs(output_lines) do
          vim.notify(string.format("[%d]: %s", i, line), vim.log.levels.INFO)
        end
        vim.notify("--- Raw ESLint Output End ---", vim.log.levels.INFO)
      end
    end,
  }

  local job_id = vim.fn.jobstart({ "pnpm", "lint:check" }, job_options)

  if not job_id or job_id == 0 or job_id == -1 then
    vim.notify("Failed to start ESLint job (pnpm lint:check).", vim.log.levels.ERROR)
    return
  end

  vim.notify("Running pnpm lint:check ...", vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("EslintCheck", M.run_eslint_check, {
  nargs = 0,
  desc = "Run pnpm lint:check and populate ESLint issues in quickfix",
  force = true,
})

return M

-- [[
--		Runs the command `npx tsc --noEmit --pretty false` and parses its outputs into quickfix list
--
--		Shamefully vibe-coded with the help of gemini-2.5pro (in like 7 iterations)
-- ]]

---@diagnostic disable: missing-fields
---@diagnostic disable: unused-local

---@class TscQuickFixItem : vim.quickfix.entry
-- No specific additions needed beyond standard vim.QuickFixItem for this use case

---@class TscQuickFixModule
---@field run_tsc_check fun():nil
local M = {}

--- Parses lines formatted by awk (filename|lnum|col|text) into quickfix items.
---@param awk_output_lines string[] Table of strings, each pipe-delimited.
---@return TscQuickFixItem[] qf_list A table of quickfix item tables.
local function build_qf_list_from_awk(awk_output_lines)
  ---@type TscQuickFixItem[]
  local qf_list = {}
  for _, line in ipairs(awk_output_lines) do
    local parts = vim.split(line, "|", { trimempty = true })
    if #parts == 4 then
      local filename = parts[1]
      local lnum = tonumber(parts[2])
      local col = tonumber(parts[3])
      local text = parts[4]

      -- Basic validation
      if
        filename
        and lnum
        and col
        and text
        and (vim.fn.filereadable(filename) == 1 or vim.fn.isdirectory(filename) == 0)
      then
        table.insert(qf_list, {
          filename = filename,
          lnum = lnum,
          col = col,
          text = text,
          type = "E", -- E for Error
        })
      end
    end
  end
  return qf_list
end

--- Runs 'npx tsc --noEmit --pretty false', parses output with awk,
--- and populates the quickfix list.
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
      local awk_script = [[
      BEGIN { OFS="|" }
      {
          if (match($0, /^(.*)\(([0-9]+),([0-9]+)\): (error TS[0-9]+: .*)$/, arr)) {
              gsub(/^[ \t]+|[ \t]+$/, "", arr[1]);
              gsub(/^[ \t]+|[ \t]+$/, "", arr[4]);
              print arr[1], arr[2], arr[3], arr[4];
          }
      }
      ]]

      ---@type string[] awk command results
      local awk_results = vim.fn.systemlist({ "awk", awk_script }, table.concat(output_lines, "\n"))

      ---@type TscQuickFixItem[]
      local qf_list = build_qf_list_from_awk(awk_results)

      if #qf_list > 0 then
        vim.fn.setqflist({}, " ", { title = "TSC Errors (awk)", items = qf_list })
        vim.cmd("copen")
        vim.notify("TSC check finished. Found " .. #qf_list .. " errors.", vim.log.levels.INFO)
      elseif code == 0 then
        vim.fn.setqflist({}, "r", { title = "TSC Errors (awk)", items = {} })
        vim.cmd("cclose")
        vim.notify("TSC check finished. No errors found.", vim.log.levels.INFO)
      elseif code ~= 0 and #qf_list == 0 then
        vim.fn.setqflist({}, "r", { title = "TSC Errors (awk)", items = {} })
        vim.cmd("cclose")
        vim.notify("TSC check failed or produced no parsable errors. Exit code: " .. code, vim.log.levels.WARN)
      end
    end,
  }

  ---@type number|nil job_id The started job's ID or nil on failure.
  local job_id = vim.fn.jobstart({ "npx", "tsc", "--noEmit", "--pretty", "false" }, job_options)

  if not job_id or job_id == 0 or job_id == -1 then
    vim.notify("Failed to start npx tsc job.", vim.log.levels.ERROR)
    return
  end

  vim.notify("Running npx tsc --noEmit...", vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("TscCheck", M.run_tsc_check, {
  nargs = 0,
  desc = "Run npx tsc --noEmit (using awk) and populate quickfix list",
  force = true, -- Overwrite previous command if it exists
})

return M

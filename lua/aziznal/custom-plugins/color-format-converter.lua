--- Detects the color format of a given input string.
--- Shamefully created with Gemini 2.5 Pro (in ~ 5 iterations)
-- @param input string The color string to detect.
-- @return string Detected format ("hex", "rgb", "rgba", "hsl", "hsla", "oklab", "oklch", "unknown").
function detect_color_format(input)
  input = input:match("^%s*(.-)%s*$")
  if
    input:match("^#%x%x%x%x?$")
    or input:match("^#%x%x%x%x%x%x$")
    or input:match("^#%x%x%x%x%x%x%x%x$")
    or input:match("^#%x%x%x%x%x%x%x?$")
  then
    return "hex"
  end
  if input:match("^rgb%(%s*%d+%s*,%s*%d+%s*,%s*%d+%s*%)$") then
    return "rgb"
  end
  if input:match("^rgba%(%s*%d+%s*,%s*%d+%s*,%s*%d+%s*,%s*[%d%.]+%s*%)$") then
    return "rgba"
  end
  if input:match("^hsl%(%s*[%d%.]+%s*,%s*[%d%.]+%%%s*,%s*[%d%.]+%%%s*%)$") then
    return "hsl"
  end
  if input:match("^hsla%(%s*[%d%.]+%s*,%s*[%d%.]+%%%s*,%s*[%d%.]+%%%s*,%s*[%d%.]+%s*%)$") then
    return "hsla"
  end
  if input:match("^oklab%(%s*[%d%.]+%s+[%d%.%-]+%s+[%d%.%-]+%s*%)$") then
    return "oklab"
  end
  if
    input:match("^oklch%(%s*[%d%.]+%s+[%d%.]+%s+[%d%.]+%s*%)$")
    or input:match("^oklch%(%s*[%d%.]+%s+[%d%.]+%s+[%d%.]+%s*/%s*[%d%.]+%s*%)$")
  then
    return "oklch"
  end
  return "unknown"
end

--[[----------------------------------------------------------------------------
  PARSERS (Input Format -> RGBA Table)
----------------------------------------------------------------------------]]
--

--- Parses a hex string to an RGBA table.
-- @param input string The hex color string (e.g., "#ffcc00").
-- @return table|nil An RGBA table {r, g, b, a} or nil if invalid.
local function parse_hex(input)
  local hex = input:match("^#([%x]+)$")
  if not hex then
    return nil
  end
  if #hex == 3 then
    local r = tonumber(hex:sub(1, 1), 16) * 17
    local g = tonumber(hex:sub(2, 2), 16) * 17
    local b = tonumber(hex:sub(3, 3), 16) * 17
    return { r, g, b, 1 }
  elseif #hex == 4 then
    local r = tonumber(hex:sub(1, 1), 16) * 17
    local g = tonumber(hex:sub(2, 2), 16) * 17
    local b = tonumber(hex:sub(3, 3), 16) * 17
    local a = tonumber(hex:sub(4, 4), 16) * 17 / 255
    return { r, g, b, a }
  elseif #hex == 6 then
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)
    return { r, g, b, 1 }
  elseif #hex == 8 then
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)
    local a = tonumber(hex:sub(7, 8), 16) / 255
    return { r, g, b, a }
  end
  return nil
end

--- Parses an rgb() string to an RGBA table.
-- @param input string The rgb() color string.
-- @return table|nil An RGBA table {r, g, b, a} or nil if invalid.
local function parse_rgb(input)
  local r, g, b = input:match("^rgb%(%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*%)$")
  if r then
    return { tonumber(r), tonumber(g), tonumber(b), 1 }
  end
  return nil
end

--- Parses an rgba() string to an RGBA table.
-- @param input string The rgba() color string.
-- @return table|nil An RGBA table {r, g, b, a} or nil if invalid.
local function parse_rgba(input)
  local r, g, b, a = input:match("^rgba%(%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*,%s*([%d%.]+)%s*%)$")
  if r then
    return { tonumber(r), tonumber(g), tonumber(b), tonumber(a) }
  end
  return nil
end

--- Converts HSL values to an RGBA table.
-- @param h number Hue (0-360).
-- @param s number Saturation (0-100).
-- @param l number Lightness (0-100).
-- @param a number Alpha (0-1).
-- @return table An RGBA table {r, g, b, a}.
function hsl_to_rgba(h, s, l, a)
  h = h % 360
  s = s / 100
  l = l / 100
  local c = (1 - math.abs(2 * l - 1)) * s
  local x = c * (1 - math.abs((h / 60) % 2 - 1))
  local m = l - c / 2
  local r1, g1, b1 = 0, 0, 0
  if h < 60 then
    r1, g1, b1 = c, x, 0
  elseif h < 120 then
    r1, g1, b1 = x, c, 0
  elseif h < 180 then
    r1, g1, b1 = 0, c, x
  elseif h < 240 then
    r1, g1, b1 = 0, x, c
  elseif h < 300 then
    r1, g1, b1 = x, 0, c
  else
    r1, g1, b1 = c, 0, x
  end
  return {
    math.floor((r1 + m) * 255 + 0.5),
    math.floor((g1 + m) * 255 + 0.5),
    math.floor((b1 + m) * 255 + 0.5),
    a,
  }
end

--- Parses an hsl() string to an RGBA table.
-- @param input string The hsl() color string.
-- @return table|nil An RGBA table {r, g, b, a} or nil if invalid.
local function parse_hsl(input)
  local h, s, l = input:match("^hsl%(%s*([%d%.]+)%s*,%s*([%d%.]+)%%%s*,%s*([%d%.]+)%%%s*%)$")
  if h then
    return hsl_to_rgba(tonumber(h), tonumber(s), tonumber(l), 1)
  end
  return nil
end

--- Parses an hsla() string to an RGBA table.
-- @param input string The hsla() color string.
-- @return table|nil An RGBA table {r, g, b, a} or nil if invalid.
local function parse_hsla(input)
  local h, s, l, a = input:match("^hsla%(%s*([%d%.]+)%s*,%s*([%d%.]+)%%%s*,%s*([%d%.]+)%%%s*,%s*([%d%.]+)%s*%)$")
  if h then
    return hsl_to_rgba(tonumber(h), tonumber(s), tonumber(l), tonumber(a))
  end
  return nil
end

--[[----------------------------------------------------------------------------
  OKLCH / OKLAB MATH HELPERS
----------------------------------------------------------------------------]]
--

local function oklch_to_oklab(L, C, H)
  local h_rad = H * math.pi / 180
  return L, C * math.cos(h_rad), C * math.sin(h_rad)
end

local function oklab_to_oklch(L, a, b)
  local C = math.sqrt(a * a + b * b)
  local H = math.atan2(b, a) * 180 / math.pi
  if H < 0 then
    H = H + 360
  end
  return L, C, H
end

local function oklab_to_linear_srgb(L, a, b)
  local l_ = L + 0.3963377774 * a + 0.2158037573 * b
  local m_ = L - 0.1055613458 * a - 0.0638541728 * b
  local s_ = L - 0.0894841775 * a - 1.2914855480 * b
  l_ = l_ * l_ * l_
  m_ = m_ * m_ * m_
  s_ = s_ * s_ * s_
  local r = 4.0767416621 * l_ - 3.3077115913 * m_ + 0.2309699292 * s_
  local g = -1.2684380046 * l_ + 2.6097574011 * m_ - 0.3413193965 * s_
  local b = -0.0041960863 * l_ - 0.7034186147 * m_ + 1.7076147010 * s_
  return r, g, b
end

local function linear_srgb_to_oklab(r, g, b)
  local l_ = 0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b
  local m_ = 0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b
  local s_ = 0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b
  l_ = l_ ^ (1 / 3)
  m_ = m_ ^ (1 / 3)
  s_ = s_ ^ (1 / 3)
  local L = 0.2104542553 * l_ + 0.7936177850 * m_ - 0.0040720468 * s_
  local a = 1.9779984951 * l_ - 2.4285922050 * m_ + 0.4505937099 * s_
  local b = 0.0259040371 * l_ + 0.7827717662 * m_ - 0.8086757660 * s_
  return L, a, b
end

local function linear_to_srgb(x)
  if x <= 0.0031308 then
    return 12.92 * x
  else
    return 1.055 * x ^ (1 / 2.4) - 0.055
  end
end

local function srgb_to_linear(x)
  if x <= 0.04045 then
    return x / 12.92
  else
    return ((x + 0.055) / 1.055) ^ 2.4
  end
end

local function clamp(x, minv, maxv)
  if x < minv then
    return minv
  end
  if x > maxv then
    return maxv
  end
  return x
end

--- Parses an oklch() string to an RGBA table.
-- @param input string The oklch() color string.
-- @return table|nil An RGBA table {r, g, b, a} or nil if invalid.
local function parse_oklch(input)
  local L, C, H, A = input:match("^oklch%(%s*([%d%.]+)%s+([%d%.]+)%s+([%d%.]+)%s*/%s*([%d%.]+)%s*%)$")
  if not L then
    L, C, H = input:match("^oklch%(%s*([%d%.]+)%s+([%d%.]+)%s+([%d%.]+)%s*%)$")
  end
  if not L then
    return nil
  end
  L, C, H = tonumber(L), tonumber(C), tonumber(H)
  A = tonumber(A) or 1
  local l, a, b = oklch_to_oklab(L, C, H)
  local r_lin, g_lin, b_lin = oklab_to_linear_srgb(l, a, b)
  local r = clamp(linear_to_srgb(r_lin), 0, 1)
  local g = clamp(linear_to_srgb(g_lin), 0, 1)
  local b = clamp(linear_to_srgb(b_lin), 0, 1)
  return { math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5), A }
end

--[[----------------------------------------------------------------------------
  FORMATTERS (RGBA Table -> Output String)
----------------------------------------------------------------------------]]
--

--- Converts an RGBA table to a hex string.
-- @param rgba table An RGBA table {r, g, b, a}.
-- @return string The hex color string (#RRGGBB or #RRGGBBAA).
function rgba_to_hex(rgba)
  local r, g, b, a = rgba[1], rgba[2], rgba[3], rgba[4]
  if a == nil or a >= 1 then
    return string.format("#%02x%02x%02x", r, g, b)
  else
    return string.format("#%02x%02x%02x%02x", r, g, b, math.floor(a * 255 + 0.5))
  end
end

--- Converts an RGBA table to an rgb() or rgba() string.
-- @param rgba table An RGBA table {r, g, b, a}.
-- @return string The rgb() or rgba() color string.
function rgba_to_rgb_or_rgba(rgba)
  local r, g, b, a = rgba[1], rgba[2], rgba[3], rgba[4]
  if a == nil or a >= 1 then
    return string.format("rgb(%d, %d, %d)", r, g, b)
  else
    return string.format("rgba(%d, %d, %d, %.3g)", r, g, b, a)
  end
end

--- Converts an RGBA table to an hsl() or hsla() string.
-- @param rgba table An RGBA table {r, g, b, a}.
-- @return string The hsl() or hsla() color string.
function rgba_to_hsl_or_hsla(rgba)
  local r, g, b, a = rgba[1] / 255, rgba[2] / 255, rgba[3] / 255, rgba[4]
  local max = math.max(r, g, b)
  local min = math.min(r, g, b)
  local h, s, l
  l = (max + min) / 2
  if max == min then
    h, s = 0, 0
  else
    local d = max - min
    s = l > 0.5 and d / (2 - max - min) or d / (max + min)
    if max == r then
      h = (g - b) / d + (g < b and 6 or 0)
    elseif max == g then
      h = (b - r) / d + 2
    else
      h = (r - g) / d + 4
    end
    h = h * 60
  end
  s = s * 100
  l = l * 100
  if a == nil or a >= 1 then
    return string.format("hsl(%.0f,%.0f%%,%.0f%%)", h, s, l)
  else
    return string.format("hsla(%.0f,%.0f%%,%.0f%%,%.3g)", h, s, l, a)
  end
end

--- Converts an RGBA table to an oklch() string.
-- @param rgba table An RGBA table {r, g, b, a}.
-- @return string The oklch() color string.
function rgba_to_oklch(rgba)
  local r, g, b, a = rgba[1] / 255, rgba[2] / 255, rgba[3] / 255, rgba[4]
  r, g, b = srgb_to_linear(r), srgb_to_linear(g), srgb_to_linear(b)
  local L, A, B = linear_srgb_to_oklab(r, g, b)
  local lch_L, lch_C, lch_H = oklab_to_oklch(L, A, B)
  if a == nil or a >= 1 then
    return string.format("oklch(%.4f %.4f %.2f)", lch_L, lch_C, lch_H)
  else
    return string.format("oklch(%.4f %.4f %.2f / %.3g)", lch_L, lch_C, lch_H, a)
  end
end

--[[----------------------------------------------------------------------------
  MAIN CONVERSION FUNCTION
----------------------------------------------------------------------------]]
--

--- Converts a color string from a source format to a target format.
-- @param input string The source color string.
-- @param target string The target format ("hex", "rgb", "rgba", "hsl", "hsla", "oklch").
-- @return string|nil The converted color string, or nil if conversion fails.
function convert_color(input, target)
  local t = detect_color_format(input)
  local rgba

  if t == "hex" then
    rgba = parse_hex(input)
  elseif t == "rgb" then
    rgba = parse_rgb(input)
  elseif t == "rgba" then
    rgba = parse_rgba(input)
  elseif t == "hsl" then
    rgba = parse_hsl(input)
  elseif t == "hsla" then
    rgba = parse_hsla(input)
  elseif t == "oklch" then
    rgba = parse_oklch(input)
  else
    return nil
  end

  if not rgba then
    return nil
  end

  if target == "hex" then
    return rgba_to_hex(rgba)
  elseif target == "rgb" or target == "rgba" then
    return rgba_to_rgb_or_rgba(rgba)
  elseif target == "hsl" or target == "hsla" then
    return rgba_to_hsl_or_hsla(rgba)
  elseif target == "oklch" then
    return rgba_to_oklch(rgba)
  end
  return nil
end

--[[----------------------------------------------------------------------------
  CREATING NVIM COMMAND
----------------------------------------------------------------------------]]
--

-- List of valid target formats for autocompletion
local supported_formats = { "hex", "rgb", "rgba", "hsl", "hsla", "oklch" }

-- Create the :ConvertColor command
vim.api.nvim_create_user_command("ConvertColor", function(opts)
  -- Get the target format from the command argument
  local target_format = opts.fargs[1]
  if not target_format then
    vim.notify("Error: No target format specified.", vim.log.levels.ERROR)
    return
  end

  -- Get the visually selected text
  local line_start, col_start = unpack(vim.api.nvim_buf_get_mark(0, "<"))
  local line_end, col_end = unpack(vim.api.nvim_buf_get_mark(0, ">"))
  local input_lines = vim.api.nvim_buf_get_lines(0, line_start - 1, line_end, false)
  local input_color = table.concat(input_lines, "\n")
  if #input_lines == 1 then
    input_color = input_color:sub(col_start + 1, col_end + 1)
  end

  -- Call the main conversion function
  local result = convert_color(input_color, target_format)

  if result then
    -- Replace the selected text with the result
    vim.api.nvim_buf_set_text(0, line_start - 1, col_start, line_end - 1, col_end + 1, { result })
  else
    vim.notify("Conversion failed for: " .. input_color, vim.log.levels.ERROR)
  end
end, {
  nargs = 1, -- Requires one argument (the target format)
  range = true, -- Works on a visual selection
  -- Autocompletion for the target format
  complete = function(arg_lead, cmd_line, cursor_pos)
    return vim.tbl_filter(function(format)
      return vim.startswith(format, arg_lead)
    end, supported_formats)
  end,
})

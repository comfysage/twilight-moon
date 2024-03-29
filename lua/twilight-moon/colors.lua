---@class twilight.types.Color { [1]: string, [2]: number }

---@alias twilight.types.ColorField 'bg0_hard'|'bg0_soft'|'bg0'|'bg1'|'bg2'|'bg3'|'bg4'|'bg5'|'bg_visual'|'bg_red'|'bg_green'|'bg_blue'|'bg_yellow'|'fg'|'red'|'orange'|'yellow'|'green'|'aqua'|'blue'|'purple'|'grey0'|'grey1'|'grey2'
---@alias twilight.types.Colors { [twilight.types.ColorField]: twilight.types.Color }

---@type twilight.types.Colors
_G.twilight_colors = {
  bg0_hard    = { "#1B1E2B", 0 },
  bg0         = { "#262A38", 0 },
  bg0_soft    = { "#32374D", 0 },
  bg1         = { "#424760", 8 },
  bg2         = { "#4B506D", 8 },
  bg3         = { "#545A78", 8 },
  bg4         = { "#5A6181", 8 },
  bg5         = { "#60678A", 8 },
  fg          = { "#DFE2F0", 7 },
  red         = { "#E6787A", 1 },
  orange      = { "#E6AF8F", 11 },
  yellow      = { "#DDCCA3", 3 },
  green       = { "#BECEB1", 2 },
  aqua        = { "#A5C7AE", 6 },
  blue        = { "#97BAC7", 4 },
  purple      = { "#CEA3D6", 5 },
  grey0       = { "#CAD0E9", 8 },
  grey1       = { "#B3B5E1", 4 },
  grey2       = { "#ADA8E0", 15 },
  hollow0     = { "#BDC7B5", 2 },
  hollow1     = { "#A4A5CC", 15 },
  hollow2     = { "#A7CCC0", 6 },
}

local M = {}

function M.colors()
  return _G.twilight_colors
end

---@param config twilight.types.Config?
---@return twilight.types.Theme
function M.setup(config)
  ---@type twilight.types.Config
  config = vim.tbl_extend("force", _G.twilight_config, config or {})
  return require 'twilight-moon.theme'.setup(M.colors(), config)
end

return M

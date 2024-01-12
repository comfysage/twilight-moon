---@class twilight.types.StyleConfig
---@field tabline { reverse: boolean, color: twilight.types.ColorField }
---@field search { reverse: boolean, inc_reverse: boolean }
---@field types { italic: boolean }
---@field keyword { italic: boolean }
---@field comment { italic: boolean }

---@class twilight.types.Theme
---@field none twilight.types.Color
---@field colors twilight.types.Colors
---@field base { fg: twilight.types.Color, bg: twilight.types.Color }
---@field bg twilight.types.Color
---@field fg twilight.types.Color
---@field bg0 twilight.types.Color
---@field bg1 twilight.types.Color
---@field bg2 twilight.types.Color
---@field bg3 twilight.types.Color
---@field fg0 twilight.types.Color
---@field fg1 twilight.types.Color
---@field fg2 twilight.types.Color
---@field hollow0 twilight.types.Color
---@field hollow1 twilight.types.Color
---@field hollow2 twilight.types.Color
---@field red  twilight.types.Color
---@field yellow twilight.types.Color
---@field orange twilight.types.Color
---@field green twilight.types.Color
---@field aqua twilight.types.Color
---@field blue twilight.types.Color
---@field purple twilight.types.Color
---@field syntax twilight.types.Syntax
---@field diagnostic { ['ok'|'error'|'warn'|'info'|'hint']: twilight.types.Color }
---@field diff { ['add'|'delete'|'change']: twilight.types.Color }
---@field style twilight.types.StyleConfig
---@field sign twilight.types.Color
---@field comment twilight.types.Color
---@field bg_accent twilight.types.Color

---@class twilight.types.Syntax
---@field keyword twilight.types.Color
---@field object twilight.types.Color
---@field field twilight.types.Color
---@field type twilight.types.Color
---@field context twilight.types.Color
---@field constant twilight.types.Color
---@field call twilight.types.Color
---@field string twilight.types.Color
---@field macro twilight.types.Color
---@field annotation twilight.types.Color

local M = {}

---@param colors twilight.types.Colors
---@param config twilight.types.Config
---@return twilight.types.Theme
function M.setup(colors, config)
  local theme = {}

  theme.none = { 'NONE', 0 }
  theme.colors = colors

  theme.bg = theme.none
  if not config.transparent_background then
    theme.bg = colors.bg0
    if config.contrast_dark == 'hard' then
      theme.bg = colors.bg0_hard
    end
    if config.contrast_dark == 'soft' then
      theme.bg = colors.bg0_soft
    end
  end
  theme.base = { fg = colors.bg0, bg = theme.bg }
  theme.fg = colors.fg

  theme.bg0 = colors.bg0
  theme.bg1 = colors.bg1
  theme.bg2 = colors.bg2
  theme.bg3 = colors.bg3

  theme.fg0 = colors.fg
  theme.fg1 = colors.grey0
  theme.fg2 = colors.grey1
  theme.fg3 = colors.grey2
  theme.hollow0 = colors.hollow0
  theme.hollow1 = colors.hollow1
  theme.hollow2 = colors.hollow2

  local sign_colors = { soft = theme.bg3 }
  theme.sign = sign_colors[config.contrast_dark] or theme.none
  theme.comment = colors.bg4
  theme.bg_accent = theme.bg2

  theme.red = colors.red
  theme.orange = colors.orange
  theme.yellow = colors.yellow
  theme.green = colors.green
  theme.aqua = colors.aqua
  theme.blue = colors.blue
  theme.purple = colors.purple

  theme.syntax = {
    keyword = theme.fg3,
    object = theme.fg1,
    field = theme.hollow1,
    type = theme.yellow,
    context = theme.hollow1,
    constant = theme.purple,
    call = theme.hollow2,
    string = theme.green,
    macro = theme.orange,
    annotation = theme.orange,
  }
  theme.diagnostic = {
    ok = theme.green,
    error = theme.red,
    warn = theme.yellow,
    info = theme.aqua,
    hint = theme.blue,
  }
  theme.diff = {
    add = theme.green,
    delete = theme.red,
    change = theme.aqua,
  }

  theme.style = {
    search = { reverse = true },
  }
  theme.style = vim.tbl_deep_extend('force', theme.style, config.style)

  return theme
end

return M

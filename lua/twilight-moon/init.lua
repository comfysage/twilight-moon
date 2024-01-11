local twilight = {}

---@class twilight.types.Config
---@field transparent_background boolean
---@field contrast_dark 'hard'|'medium'|'soft'
---@field override_terminal boolean
---@field style twilight.types.StyleConfig
---@field overrides twilight.types.HLGroups

---@type twilight.types.Config
twilight.default_config = {
    transparent_background = false,
    contrast_dark = 'medium',
    override_terminal = true,
    style = {
        tabline = { reverse = true, color = 'green' },
        search = { reverse = false, inc_reverse = true },
        types = { italic = true },
        keyword = { italic = true },
        comment = { italic = false },
    },
    overrides = {},
}

---@type twilight.types.Config
_G.twilight_config = vim.tbl_deep_extend("force", twilight.default_config, _G.twilight_config or {})

---@param config twilight.types.Config|table
function twilight.setup(config)
    _G.twilight_config = vim.tbl_deep_extend("force", _G.twilight_config, config or {})
end

---@param group string
---@param colors twilight.types.ColorSpec
local function set_hi(group, colors)
    if not vim.tbl_isempty(colors) then
        ---@type vim.api.keyset.highlight
        local color = colors
        color.fg = colors[1] and colors[1][1] or 'NONE'
        color.bg = colors[2] and colors[2][1] or 'NONE'
        color.ctermfg = colors[1] and colors[1][2] or 'NONE'
        color.ctermbg = colors[2] and colors[2][2] or 'NONE'
        color[1] = nil
        color[2] = nil
        vim.api.nvim_set_hl(0, group, color)
    end
end

---@param hlgroups twilight.types.HLGroups
local function set_highlights(hlgroups)
    vim.cmd("highlight Normal guifg=" .. hlgroups.Normal[1][1] .. " guibg=" .. hlgroups.Normal[2][1].. " ctermfg=" .. hlgroups.Normal[1][2] .. " ctermbg=" .. hlgroups.Normal[2][2])
    hlgroups.Normal = nil
    for group, colors in pairs(hlgroups) do
        set_hi(group, colors)
    end
end

function twilight.load(_)
    if vim.g.colors_name then
        vim.cmd('hi clear')
    end

    vim.g.colors_name = 'twilight-moon'
    vim.o.termguicolors = true

    -- if vim.o.background == 'light' then
    --     _G.twilight_config.theme = 'light'
    -- elseif vim.o.background == 'dark' then
    --     _G.twilight_config.theme = 'default'
    -- end

    local theme = require 'twilight-moon.colors'.setup()
    local hlgroups = require 'twilight-moon.hl.init'.setup(theme, _G.twilight_config)

    set_highlights(hlgroups)
end

function twilight.colors()
    return require 'twilight-moon.colors'.colors()
end

return twilight

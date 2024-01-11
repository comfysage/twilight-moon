local twilight_moon = R 'twilight-moon'
twilight_moon.setup {
    transparent_background = false,
    contrast_dark = 'medium',
    style = {
        tabline = { reverse = true, color = "green" },
        search = { reverse = false, inc_reverse = true },
        types = { italic = true },
        keyword = { italic = false },
        comment = { italic = true },
    },
}
twilight_moon.load {}

-- [NOTE] is needed to reload lualine
vim.api.nvim_exec_autocmds('ColorScheme', {})

-- vim.o.termguicolors = false

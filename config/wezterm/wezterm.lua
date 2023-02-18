local wezterm = require 'wezterm'


function readall(filename)
    local fh = assert(io.open(filename, 'rb'))
    local contents = assert(fh:read('a'))
    fh:close()
    return contents
end


wal = wezterm.json_parse(
    readall(
        wezterm.home_dir .. '/.cache/wal/colors.json'
    )
)


return {
    colors = {
        ansi = {
            wal.colors.color0,
            wal.colors.color1,
            wal.colors.color2,
            wal.colors.color3,
            wal.colors.color4,
            wal.colors.color5,
            wal.colors.color6,
            wal.colors.color7,
        },
        background = wal.special.background,
        brights = {
            wal.colors.color8,
            wal.colors.color9,
            wal.colors.color10,
            wal.colors.color11,
            wal.colors.color12,
            wal.colors.color13,
            wal.colors.color14,
            wal.colors.color15,
        },
        cursor_bg = wal.special.cursor,
        cursor_border = wal.special.cursor,
        cursor_fg = wal.special.background,
        foreground = wal.special.foreground,
        scrollbar_thumb = wal.colors.color8,
        selection_bg = wal.special.foreground,
        selection_fg = wal.special.background
    },
    default_cursor_style = 'SteadyBar',
    disable_default_key_bindings = true,
    font = wezterm.font {
        family = 'FiraCodeNerdFontCompleteM-Retina',
        harfbuzz_features = {
            'cv02',
            'ss01',
            'ss03',
            'ss04'
        },
    },
    font_size = 12,
    hide_tab_bar_if_only_one_tab = true,
    keys = {
        {
            action = wezterm.action.CopyTo 'Clipboard',
            key = 'c',
            mods = 'CTRL|SHIFT'
        },
        {
            action = wezterm.action.DecreaseFontSize,
            key = '-',
            mods = 'CTRL'
        },
        {
            action = wezterm.action.IncreaseFontSize,
            key = '=',
            mods = 'CTRL'
        },
        {
            action = wezterm.action.PasteFrom 'Clipboard',
            key = 'v',
            mods = 'CTRL|SHIFT'
        },
        {
            action = wezterm.action.ResetFontSize,
            key = '0',
            mods = 'CTRL'
        }
    },
    window_padding = {
        left = 16,
        right = 16,
        top = 24,
        bottom = 24
    }
}

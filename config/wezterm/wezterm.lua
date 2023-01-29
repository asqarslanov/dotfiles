local wezterm = require 'wezterm'

return {
    color_scheme = 'Abernathy',
    default_cursor_style = 'SteadyBar',
    font = wezterm.font {
        family = 'FiraCodeNerdFontCompleteM-Retina',
        harfbuzz_features = {
            'cv02',
            'ss01',
            'ss03',
            'ss04',
            'ss07'
        },
    },
    font_size = 12,
    hide_tab_bar_if_only_one_tab = true,
    window_padding = {
        left = 16,
        right = 16,
        top = 24,
        bottom = 24
    }
}

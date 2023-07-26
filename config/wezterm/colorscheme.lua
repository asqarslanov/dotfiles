local module = {}

local COLOR_SCHEME <const> = "Dracula (Official)"

local wal
local function read_wal()
	wal = require("wal")
end

function module.apply_to_config(config)
	config.color_scheme = COLOR_SCHEME

	-- if pcall(read_wal) then
	if false then
		config.colors = {
			background = wal.special.background,
			foreground = wal.special.foreground,
			cursor_bg = wal.special.cursor,
			cursor_fg = wal.special.background,
			cursor_border = wal.special.cursor,
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
		}

		config.window_frame = {
			inactive_titlebar_bg = wal.colors.color0,
			active_titlebar_bg = wal.special.background,
		}
	end
end

return module

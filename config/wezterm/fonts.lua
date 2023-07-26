local wezterm = require("wezterm")
local module = {}

local FONT_SIZE <const> = 13

local FIRACODE_FEATURES <const> = { "cv02", "ss01", "ss03", "ss04" }
local JETBRAINSMONO_FEATURES <const> = { "zero", "cv14" }

local RETINA_WEIGHT <const> = 450
local HALF_WEIGHT <const> = 550

function module.apply_to_config(config)
	config.font_rules = {
		{
			intensity = "Normal",
			italic = false,
			font = wezterm.font({
				family = "FiraCode Nerd Font Mono",
				weight = RETINA_WEIGHT,
				harfbuzz_features = FIRACODE_FEATURES,
			}),
		},
		{
			intensity = "Half",
			italic = false,
			font = wezterm.font({
				family = "FiraCode Nerd Font Mono",
				weight = HALF_WEIGHT,
				harfbuzz_features = FIRACODE_FEATURES,
			}),
		},
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font({
				family = "FiraCode Nerd Font Mono",
				weight = "Bold",
				harfbuzz_features = FIRACODE_FEATURES,
			}),
		},
		{
			intensity = "Normal",
			italic = true,
			font = wezterm.font({
				family = "JetBrains Mono",
				weight = "Regular",
				style = "Italic",
				harfbuzz_features = JETBRAINSMONO_FEATURES,
			}),
		},
		{
			intensity = "Half",
			italic = true,
			font = wezterm.font({
				family = "JetBrains Mono",
				weight = HALF_WEIGHT,
				style = "Italic",
				harfbuzz_features = JETBRAINSMONO_FEATURES,
			}),
		},
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font({
				family = "JetBrains Mono",
				weight = "Bold",
				style = "Italic",
				harfbuzz_features = JETBRAINSMONO_FEATURES,
			}),
		},
	}

	config.font_size = FONT_SIZE
end

return module

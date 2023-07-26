local wezterm = require("wezterm")
local module = {}

function module.apply_to_config(config)
	config.disable_default_key_bindings = true

	config.keys = {
		{
			action = wezterm.action.CopyTo("Clipboard"),
			key = "c",
			mods = "CTRL|SHIFT",
		},
		{
			action = wezterm.action.DecreaseFontSize,
			key = "-",
			mods = "CTRL",
		},
		{
			action = wezterm.action.IncreaseFontSize,
			key = "=",
			mods = "CTRL",
		},
		{
			action = wezterm.action.PasteFrom("Clipboard"),
			key = "v",
			mods = "CTRL|SHIFT",
		},
		{
			action = wezterm.action.ResetFontSize,
			key = "0",
			mods = "CTRL",
		},
	}
end

return module

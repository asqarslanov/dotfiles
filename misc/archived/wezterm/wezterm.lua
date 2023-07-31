local wezterm = require("wezterm")
local config

if wezterm.config_builder then
	config = wezterm.config_builder()
else
	config = {}
end

local MODULES <const> = {
	"appearance",
	"behavior",
	"colorscheme",
	"fonts",
	"keybindings",
}

for _, module in pairs(MODULES) do
	require(module).apply_to_config(config)
end

return config

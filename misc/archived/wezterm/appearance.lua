local module = {}

function module.apply_to_config(config)
	config.default_cursor_style = "SteadyBar"
	config.hide_tab_bar_if_only_one_tab = true
	config.window_padding = {
		left = "1cell",
		right = "1cell",
		top = "0.5cell",
		bottom = "0cell",
	}
end

return module

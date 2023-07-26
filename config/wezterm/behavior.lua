local module = {}

function module.apply_to_config(config)
	config.skip_close_confirmation_for_processes_named = {
		"bash",
		"fish",
		"sh",
		"tmux",
	}
end

return module

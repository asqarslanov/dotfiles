table.insert(default_access.rules, { ---@diagnostic disable-line: undefined-global
	matches = { { { "application.process.binary", "=", "ferdium" } } },
	default_permissions = "rx",
})

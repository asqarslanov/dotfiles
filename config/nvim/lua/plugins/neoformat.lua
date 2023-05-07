return {
	"sbdchd/neoformat",

	config = function()
		vim.g.neoformat_run_all_formatters = true

		vim.g.neoformat_enabled_python = { "black", "isort" }
		vim.g.neoformat_enabled_rust = { "rustfmt" }
	end,

	event = "VeryLazy",
}

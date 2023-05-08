return {
	"Mofiqul/dracula.nvim",

	opts = function()
		local dracula = require("dracula")
		return {
			indent_color = dracula.colors().purple,
			indent_color_zen = dracula.colors().comment,
			ts_rainbow_colors = {
				dracula.colors().pink,
				dracula.colors().cyan,
				dracula.colors().green,
				dracula.colors().purple,
				dracula.colors().orange,
			},
		}
	end,

	config = function(plugin, opts)
		vim.cmd("colorscheme dracula")

		vim.g.colorscheme_plugin_name = plugin.url

		-- plugins/mini-indentscope.lua
		vim.cmd("highlight MiniIndentscopeSymbol guifg=" .. opts.indent_color .. " gui=nocombine")
		vim.g.indent_color = opts.indent_color
		vim.g.indent_color_zen = opts.indent_color_zen

		-- plugins/treesitter.lua
		for i, color in ipairs(opts.ts_rainbow_colors) do
			vim.cmd("highlight TSRainbow" .. i .. " guifg=" .. color .. " gui=nocombine")
		end
		vim.g.ts_rainbow_colors_count = #opts.ts_rainbow_colors
	end,
}

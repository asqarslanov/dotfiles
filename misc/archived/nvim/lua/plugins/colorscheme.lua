return {
	"Mofiqul/dracula.nvim",

	opts = function()
		local dracula = require("dracula")

		return {
			indent_color = dracula.colors().purple,
			indent_color_zen = dracula.colors().comment,
			tab_bar_bg_color = dracula.colors().bg,
			tab_bar_active_color = dracula.colors().purple,
			tab_bar_inactive_color = dracula.colors().comment,
			tab_bar_separator_color = dracula.colors().selection,
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
		vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = opts.indent_color })
		vim.g.indent_color = opts.indent_color
		vim.g.indent_color_zen = opts.indent_color_zen

		-- plugins/barbar.lua
		vim.api.nvim_set_hl(0, "BufferCurrent", { bg = opts.tab_bar_bg_color })
		vim.api.nvim_set_hl(0, "BufferInactive", { bg = opts.tab_bar_bg_color, fg = opts.tab_bar_inactive_color })
		vim.api.nvim_set_hl(0, "BufferInactiveMod", { bg = opts.tab_bar_bg_color, fg = opts.tab_bar_inactive_color })
		vim.api.nvim_set_hl(0, "BufferInactiveSign", { bg = opts.tab_bar_bg_color, fg = opts.tab_bar_separator_color })
		vim.api.nvim_set_hl(0, "BufferScrollArrow", { bg = opts.tab_bar_bg_color, fg = opts.tab_bar_inactive_color })
		vim.api.nvim_set_hl(0, "BufferTabpageFill", { bg = opts.tab_bar_bg_color })
		vim.api.nvim_set_hl(0, "BufferVisible", { fg = opts.tab_bar_inactive_color })
		vim.api.nvim_set_hl(0, "BufferVisibleSign", { fg = opts.tab_bar_active_color })

		-- plugins/treesitter.lua
		for i, color in ipairs(opts.ts_rainbow_colors) do
			vim.api.nvim_set_hl(0, "TSRainbow" .. i, { fg = color })
		end
		vim.g.ts_rainbow_colors_count = #opts.ts_rainbow_colors
	end,
}

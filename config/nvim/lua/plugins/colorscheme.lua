vim.g.colorscheme_plugin_name = "Mofiqul/dracula.nvim"

return {
	vim.g.colorscheme_plugin_name,

	opts = function()
		local dracula = require("dracula")
		return {
			indent_color = dracula.colors().purple,
			ts_rainbow_colors = {
				dracula.colors().pink,
				dracula.colors().cyan,
				dracula.colors().green,
				dracula.colors().purple,
				dracula.colors().orange,
			},
		}
	end,

	config = function(_, opts)
		vim.cmd("colorscheme dracula")

		local function make_highlight(name, color)
			local command = "highlight " .. name .. " guifg=" .. color .. " gui=nocombine"
			vim.cmd(command)
		end

		-- plugins/mini-indentscope.lua
		make_highlight("MiniIndentscopeSymbol", opts.indent_color)

		-- plugins/treesitter.lua
		vim.g.ts_rainbow_colors_count = #opts.ts_rainbow_colors
		for i, color in ipairs(opts.ts_rainbow_colors) do
			make_highlight("TSRainbow" .. i, color)
		end
	end,
}

return {
	"folke/zen-mode.nvim",

	opts = {
		window = {
			backdrop = 1,
		},

		plugins = {
			gitsigns = { enabled = true },
			tmux = { enabled = true },
			kitty = { enabled = true, font = 16 },
			wezterm = { enabled = true, font = 16 },
		},

		on_open = function()
			vim.cmd("highlight MiniIndentscopeSymbol guifg=" .. vim.g.indent_color_zen .. " gui=nocombine")
		end,
		on_close = function()
			vim.cmd("highlight MiniIndentscopeSymbol guifg=" .. vim.g.indent_color .. " gui=nocombine")
		end,
	},

	keys = {
		{ "<Leader>z", "<Cmd>ZenMode<CR>", desc = "Zen Mode" },
	},
}

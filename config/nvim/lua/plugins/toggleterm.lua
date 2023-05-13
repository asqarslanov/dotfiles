return {
	"akinsho/toggleterm.nvim",

	cond = not vim.g.vscode,

	opts = {
		size = function(term)
			local golden_ratio = (1.5 - math.sqrt(1.25))

			if term.direction == "horizontal" then
				return golden_ratio * vim.opt.lines._value
			elseif term.direction == "vertical" then
				return golden_ratio * vim.opt.columns._value
			end
		end,

		autochdir = true,
		shade_terminals = false,
		direction = "float",
		float_opts = { border = "curved" },
	},

	config = function(_, opts)
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			float_opts = { border = "curved" },
			cmd = "lazygit",
			dir = "git_dir",
			direction = "float",
			hidden = true,
			on_open = function()
				vim.keymap.set("t", "<C-g>", "q")
			end,
			on_close = function()
				vim.keymap.set("t", "<C-g>", "<C-g>")
			end,
		})

		local function lazygit_open()
			lazygit:open()
		end

		vim.keymap.set("n", "<C-g>", lazygit_open)

		require("toggleterm").setup(opts)
	end,

	keys = {
		{ "<Bslash>f", "<Cmd>ToggleTerm direction=float<CR>" },
		{ "<Bslash>v", "<Cmd>ToggleTerm direction=vertical<CR>" },
		{ "<Bslash>h", "<Cmd>ToggleTerm direction=horizontal<CR>" },
		{ "<C-Bslash>", "<Cmd>ToggleTerm<CR>" },
		{ "<C-Bslash>", "<Cmd>ToggleTerm<CR>", mode = "t" },
		{ "<C-g>" },
	},
}

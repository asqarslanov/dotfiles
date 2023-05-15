return {
	"folke/noice.nvim",

	cond = not vim.g.vscode,

	dependencies = {
		"MunifTanjim/nui.nvim",
		-- "rcarriga/nvim-notify",
	},

	config = true,

	event = "VeryLazy",

	keys = {
		{
			"<Leader>nl",
			function()
				require("noice").cmd("last")
			end,
		},
		{
			"<Leader>nh",
			function()
				require("noice").cmd("history")
			end,
		},
	},
}

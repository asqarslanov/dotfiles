return {
	"nvim-lualine/lualine.nvim",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	opts = {
		options = {
			theme = "dracula-nvim",
			disabled_filetypes = { statusline = { "alpha" } },
		},

		extensions = {
			"lazy",
			"man",
			"neo-tree",
			"nvim-dap-ui",
			"toggleterm",
		},
	},
}

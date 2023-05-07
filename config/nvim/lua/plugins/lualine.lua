return {
	"nvim-lualine/lualine.nvim",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	opts = {},

	config = function(_, opts)
		require("lualine").setup(opts)
	end,
}

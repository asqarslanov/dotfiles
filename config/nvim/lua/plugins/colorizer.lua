return {
	"NvChad/nvim-colorizer.lua",

	opts = {
		user_default_options = {
			names = false,
			mode = "virtualtext",
			virtualtext = "󰌁",
		},

		filetypes = {
			"*",

			css = {
				names = true,
				css = true,
				tailwind = true,
			},

			scss = {
				names = true,
				css = true,
				tailwind = true,
				sass = { enable = true },
			},
		},
	},

	config = function(_, opts)
		require("colorizer").setup(opts)
	end,
}

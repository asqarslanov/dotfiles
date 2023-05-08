return {
	"NvChad/nvim-colorizer.lua",

	opts = {
		user_default_options = {
			names = false,
			css = true,
			mode = "virtualtext",
			virtualtext = "󰌁",
		},

		filetypes = {
			"*",

			css = {
				names = true,
				tailwind = true,
			},

			scss = {
				names = true,
				tailwind = true,
				sass = { enable = true },
			},
		},
	},
}

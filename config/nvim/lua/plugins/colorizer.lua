return {
	"NvChad/nvim-colorizer.lua",

	opts = {
		user_default_options = {
			RGB = false,
			names = false,
			css = true,
			mode = "virtualtext",
			virtualtext = "󰌁",
		},

		filetypes = {
			"*",

			css = {
				RGB = true,
				names = true,
				tailwind = true,
			},

			scss = {
				RGB = true,
				names = true,
				tailwind = true,
				sass = { enable = true },
			},
		},
	},
}

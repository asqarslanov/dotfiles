return {
	"ziontee113/color-picker.nvim",

	opts = {
		icons = { "-", ">" },
	},

	config = function(_, opts)
		require("color-picker").setup(opts)
	end,

	keys = {
		{ "<C-c>", "<Cmd>PickColor<CR>", desc = "Color Picker" },
		{ "<C-c>", "<Cmd>PickColorInsert<CR>", mode = "i", desc = "Color Picker Insert Mode" },
	},
}

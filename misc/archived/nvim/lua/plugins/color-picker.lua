return {
	"ziontee113/color-picker.nvim",

	opts = {
		icons = { "-", ">" },
	},

	keys = {
		{ "<C-c>", "<Cmd>PickColor<CR>", desc = "Color Picker" },
		{ "<C-c>", "<Cmd>PickColorInsert<CR>", mode = "i", desc = "Color Picker Insert Mode" },
	},
}

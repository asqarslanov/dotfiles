return {
	"ziontee113/color-picker.nvim",

	cond = not vim.g.vscode,

	opts = {
		icons = { "-", ">" },
	},

	keys = {
		{ "<C-c>", "<Cmd>PickColor<CR>", desc = "Color Picker" },
		{ "<C-c>", "<Cmd>PickColorInsert<CR>", mode = "i", desc = "Color Picker Insert Mode" },
	},
}

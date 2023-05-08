return {
	"ziontee113/color-picker.nvim",

	opts = {
		icons = { "-", ">" },
	},

	config = function(_, opts)
		require("color-picker").setup(opts)

		vim.keymap.set("n", "<C-c>", "<Cmd>PickColor<CR>")
		vim.keymap.set("i", "<C-c>", "<Cmd>PickColorInsert<CR>")
	end,

	event = "VeryLazy",
}

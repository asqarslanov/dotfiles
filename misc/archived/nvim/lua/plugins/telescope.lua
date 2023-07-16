return {
	"nvim-telescope/telescope.nvim",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
	},

	config = function()
		local builtin = require("telescope.builtin")
		local extensions = require("telescope").extensions

		vim.keymap.set("n", "<Leader>ff", builtin.find_files)
		vim.keymap.set("n", "<Leader>fg", builtin.live_grep)
		vim.keymap.set("n", "<Leader>fb", builtin.buffers)
		vim.keymap.set("n", "<Leader>fh", builtin.help_tags)
		vim.keymap.set("n", "<Leader>u", extensions.undo.undo)
	end,

	keys = {
		"<Leader>ff",
		"<Leader>fg",
		"<Leader>fb",
		"<Leader>fh",
		"<Leader>u",
	},
}

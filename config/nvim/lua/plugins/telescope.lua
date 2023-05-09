return {
	"nvim-telescope/telescope.nvim",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
	},

	keys = function()
		local builtin = require("telescope.builtin")
		local extensions = require("telescope").extensions

		return {
			{ "<Leader>ff", builtin.find_files },
			{ "<Leader>fg", builtin.live_grep },
			{ "<Leader>fb", builtin.buffers },
			{ "<Leader>fh", builtin.help_tags },
			{ "<Leader>u", extensions.undo.undo },
		}
	end,
}

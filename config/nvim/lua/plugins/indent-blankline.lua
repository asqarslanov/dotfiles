return {
	"lukas-reineke/indent-blankline.nvim",

	opts = {
		char = "▏",
		char_highlight_list = { "IndentBlanklineIndent" },
		context_char = "",
		filetype_exclude = {
			"checkhealth",
			"help",
			"lazy",
			"lspinfo",
			"man",
			"mason",
		},
		show_current_context = true,
		show_current_context_start = true,
		show_first_indent_level = false,
		use_treesitter = true,
	},

	config = function(_, opts)
		require("indent_blankline").setup(opts)
	end,
}

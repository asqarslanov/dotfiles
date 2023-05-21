return {
	"folke/noice.nvim",

	dependencies = {
		"MunifTanjim/nui.nvim",
	},

	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},

		presets = {
			bottom_search = true,
			-- command_palette = true,
			-- long_message_to_split = true, -- long messages will be sent to a split
			-- inc_rename = false, -- enables an input dialog for inc-rename.nvim
			-- lsp_doc_border = false, -- add a border to hover docs and signature help
		},
	},

	event = "VeryLazy",

	keys = {
		{
			"<Leader>nl",
			function()
				require("noice").cmd("last")
			end,
		},
		{
			"<Leader>nh",
			function()
				require("noice").cmd("history")
			end,
		},
	},
}

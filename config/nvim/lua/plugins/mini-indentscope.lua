return {
	"echasnovski/mini.indentscope",

	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"alpha",
				"checkhealth",
				"help",
				"lazy",
				"lspinfo",
				"man",
				"mason",
				"neo-tree",
				"toggleterm",
				-- "Trouble",
			},

			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
	end,

	opts = {
		options = { try_as_border = true },
		symbol = "╵",
	},

	config = function(_, opts)
		require("mini.indentscope").setup(opts)
	end,

	event = { "BufReadPre", "BufNewFile" },
}

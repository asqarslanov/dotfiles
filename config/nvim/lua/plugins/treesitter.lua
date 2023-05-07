return {
	"nvim-treesitter/nvim-treesitter",

	opts = {
		auto_install = true,
		highlight = { enable = true },
		ensure_installed = {
			"awk",
			"bash",
			"c",
			"c_sharp",
			"cmake",
			"comment",
			"cpp",
			"css",
			"diff",
			"dockerfile",
			"gitignore",
			"html",
			"http",
			"ini",
			"javascript",
			"jq",
			"json",
			"json5",
			"jsonc",
			"latex",
			"lua",
			"make",
			"markdown",
			"markdown_inline",
			"ninja",
			"passwd",
			"python",
			"regex",
			"rust",
			"scss",
			"sql",
			"toml",
			"typescript",
			"yaml",
		},
	},

	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,

	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })
	end,

	event = { "BufReadPost", "BufNewFile" },
}

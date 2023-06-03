return {
	"nvim-treesitter/nvim-treesitter",

	dependencies = {
		{
			"HiPhish/nvim-ts-rainbow2",
			dependencies = { vim.g.colorscheme_plugin_name },
		},
	},

	opts = function()
		-- plugins/colorscheme.lua
		local ts_rainbow_hlgroups = {}
		for i = 1, vim.g.ts_rainbow_colors_count do
			table.insert(ts_rainbow_hlgroups, "TSRainbow" .. i)
		end

		return {
			auto_install = true,
			highlight = { enable = true },
			ensure_installed = {
				"awk",
				"bash",
				"c",
				"cmake",
				"comment",
				"cpp",
				"css",
				"diff",
				"dockerfile",
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"html",
				"ini",
				"jq",
				"json",
				"json5",
				"jsonc",
				"latex",
				"lua",
				"make",
				"markdown",
				"markdown_inline",
				"nix",
				"passwd",
				"python",
				"regex",
				"rust",
				"scss",
				"sql",
				"toml",
				"vim",
				"yaml",
                "fish",
			},

			rainbow = {
				enable = true,
				query = { "rainbow-parens" },
				strategy = require("ts-rainbow").strategy.global,
				hlgroups = ts_rainbow_hlgroups,
			},
		}
	end,

	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,

	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })
	end,

	event = { "BufReadPost", "BufNewFile" },
}

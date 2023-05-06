local plugins = {
	{
		"williamboman/mason.nvim",
		opts = require("custom.configs.mason"),
	},
	{
		"echasnovski/mini.move",
		lazy = false,
		config = function()
			require("mini.move").setup()
		end,
	},
	{
		"echasnovski/mini.surround",
		lazy = false,
		config = function()
			require("mini.surround").setup()
		end,
	},
	{
		"sbdchd/neoformat",
		lazy = false,
		config = function()
			require("custom.configs.neoformat")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},
	{
		"mfussenegger/nvim-dap",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = require("custom.configs.nvim-treesitter"),
	},
	{
		"folke/which-key.nvim",
		enabled = false,
	},
}

return plugins

return {
	"neovim/nvim-lspconfig",

	cond = not vim.g.vscode,

	dependencies = {
		"williamboman/mason.nvim",
	},

	config = function()
		local lspconfig = require("lspconfig")

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = { Lua = { diagnostics = { globals = { "vim", "xplr" } } } },
		})
		lspconfig.pyright.setup({
			capabilities = capabilities,
		})
		lspconfig.rust_analyzer.setup({
			capabilities = capabilities,
		})
	end,

	event = { "BufReadPre", "BufNewFile" },
}

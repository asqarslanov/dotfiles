return {
	"neovim/nvim-lspconfig",

	dependencies = {
		"williamboman/mason.nvim",
	},

	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local setup_default = {
			"clangd",
			"jsonls",
			"pyright",
			"rust_analyzer",
		}

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = { Lua = { diagnostics = { globals = { "vim", "xplr" } } } },
		})

		for _, server in ipairs(setup_default) do
			lspconfig[server].setup({
				capabilities = capabilities,
			})
		end
	end,

	event = { "BufReadPre", "BufNewFile" },
}

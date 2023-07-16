return {
	"williamboman/mason.nvim",

	config = true,

	build = function()
		local ensure_installed = {
			"bash-language-server",
			"black",
			"clang-format",
			"clangd",
			"html-lsp",
			"isort",
			"jdtls",
			"json-lsp",
			"lua-language-server",
			"prettierd",
			"pyright",
			"rust-analyzer",
			"rustfmt",
			"shfmt",
			"stylua",
		}

		vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
	end,
}

return {
	"williamboman/mason.nvim",

	config = true,

	build = function()
		local ensure_installed = {
			"bash-language-server",
			"black",
			"html-lsp",
			"isort",
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

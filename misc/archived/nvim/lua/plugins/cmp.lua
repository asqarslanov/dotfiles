return {
	"hrsh7th/nvim-cmp",

	dependencies = {
		"FelipeLema/cmp-async-path",
		"andersevenrud/cmp-tmux",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"neovim/nvim-lspconfig",
		"onsails/lspkind.nvim",
		"saadparwaiz1/cmp_luasnip",
	},

	opts = function()
		local cmp = require("cmp")

		return {
			formatting = {
				format = require("lspkind").cmp_format({ ellipsis_char = "…" }),
			},

			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},

			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm(),
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "async_path" },
				{ name = "tmux" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),

			experimental = { ghost_text = { hl_group = "LspCodeLens" } },
		}
	end,

	config = function(_, opts)
		local cmp = require("cmp")

		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "async_path" },
			}, {
				{ name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
			}),
		})

		cmp.setup(opts)
	end,

	event = "VeryLazy",
}

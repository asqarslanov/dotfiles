return {
	"nvim-neo-tree/neo-tree.nvim",

	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},

	init = function()
		vim.g.neo_tree_remove_legacy_commands = true

		if vim.fn.argc() == 1 then
			local stat = vim.loop.fs_stat(vim.fn.argv(0))

			if stat and stat.type == "directory" then
				require("neo-tree")
			end
		end
	end,

	opts = {
		filesystem = {
			bind_to_cwd = false,
			follow_current_file = true,
			use_libuv_file_watcher = true,
		},

		window = {
			mappings = {
				["<Leader>"] = "none",
			},
		},

		default_component_configs = {
			indent = {
				with_expanders = true,
				expander_highlight = "NeoTreeExpander",
			},
		},
	},

	config = function(_, opts)
		require("neo-tree").setup(opts)

		vim.api.nvim_create_autocmd("TermClose", {
			pattern = "*lazygit",
			callback = function()
				if package.loaded["neo-tree.sources.git_status"] then
					require("neo-tree.sources.git_status").refresh()
				end
			end,
		})
	end,

	branch = "v2.x",

	cmd = "Neotree",

	keys = {
		{
			"<Leader>e",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
			end,
			desc = "Explorer NeoTree (cwd)",
		},
	},
}

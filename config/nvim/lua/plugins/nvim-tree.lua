-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = function(data) if vim.fn.isdirectory(data.file) ~= 1 then return end vim.cmd.cd(data.file) require("nvim-tree.api").tree.open() end, })

return {
	"nvim-tree/nvim-tree.lua",

	enabled = false,

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	opts = {},

	config = function(_, opts)
		-- require("nvim-tree").setup(opts)

		-- local api = require("nvim-tree.api") local function edit_or_open() local node = api.tree.get_node_under_cursor() if node.nodes ~= nil then -- expand or collapse folder api.node.open.edit() else -- open file api.node.open.edit() -- Close the tree if file was opened api.tree.close() end end -- open as vsplit on current node local function vsplit_preview() local node = api.tree.get_node_under_cursor() if node.nodes ~= nil then -- expand or collapse folder api.node.open.edit() else -- open file as vsplit api.node.open.vertical() end -- Finally refocus on tree if it was lost api.tree.focus() end vim.keymap.set("n", "l", edit_or_open) vim.keymap.set("n", "L", vsplit_preview) vim.keymap.set("n", "h", api.tree.close) vim.keymap.set("n", "H", api.tree.collapse_all)
	end,

	keys = {
		{ "<C-h>", "<Cmd>NvimTreeToggle<CR>", desc = "Nvim-Tree" },
	},
}

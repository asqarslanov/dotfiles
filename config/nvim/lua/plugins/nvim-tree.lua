-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
-- 	callback = function(data)
-- 		if vim.fn.isdirectory(data.file) ~= 1 then
-- 			return
-- 		end
-- 		vim.cmd.cd(data.file)
-- 		require("nvim-tree.api").tree.open()
-- 	end,
-- })

return {
	"nvim-tree/nvim-tree.lua",

	enabled = false,

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	opts = {
		on_attach = function(bufnr)
			local api = require("nvim-tree.api")

			local git_add = function()
				local node = api.tree.get_node_under_cursor()
				local gs = node.git_status.file

				if gs == nil then
					gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
						or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
				end

				if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
					vim.cmd("silent !git add " .. node.absolute_path)
				elseif gs == "M " or gs == "A " then
					vim.cmd("silent !git restore --staged " .. node.absolute_path)
				end

				api.tree.reload()
			end

			local function opts(desc)
				return { desc = "Nvim-Tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
			vim.keymap.set("n", "<Left>", api.node.navigate.parent_close, opts("Close Directory"))
			vim.keymap.set("n", "<S-Left>", api.node.navigate.parent_close, opts("Close Directory"))
			vim.keymap.set("n", "<C-Left>", api.node.navigate.parent_close, opts("Close Directory"))
			vim.keymap.set("n", "<CR>", function()
				api.node.open.edit()
				vim.cmd("NvimTreeFocus")
			end, opts("Open"))
			vim.keymap.set("n", "l", api.node.open.tab, opts("Open: New Tab"))
			vim.keymap.set("n", "<Right>", api.node.open.tab, opts("Open: New Tab"))
			vim.keymap.set("n", "L", api.node.open.preview, opts("Open Preview"))
			vim.keymap.set("n", "<S-Right>", api.node.open.preview, opts("Open Preview"))
			vim.keymap.set("n", "<C-Right>", api.node.open.preview, opts("Open Preview"))
			vim.keymap.set("n", "d", api.fs.trash, opts("Trash"))
			vim.keymap.set("n", "D", api.fs.remove, opts("Delete"))
			vim.keymap.set("n", "n", "2n0", opts("Bug Fix"))
			vim.keymap.set("n", "N", "N0", opts("Bug Fix"))
			vim.keymap.set("n", "$", "0", opts("Bug Fix"))
			vim.keymap.set("n", "^", "0", opts("Bug Fix"))
			vim.keymap.set("n", "_", "0", opts("Bug Fix"))
			vim.keymap.set("n", "g_", "0", opts("Bug Fix"))
			vim.keymap.set("n", "gm", "0", opts("Bug Fix"))
			vim.keymap.set("n", "H", "0", opts("Bug Fix"))
			vim.keymap.set("n", "gM", "0", opts("Bug Fix"))
			vim.keymap.set("n", "ge", "0", opts("Bug Fix"))
			vim.keymap.set("n", "gE", "0", opts("Bug Fix"))
			vim.keymap.set("n", "w", "0", opts("Bug Fix"))
			vim.keymap.set("n", "E", "0", opts("Bug Fix"))
			vim.keymap.set("c", "<CR>", "<CR>0", opts("Bug Fix"))
			vim.keymap.set("v", "v", "v0", opts("Bug Fix"))
			vim.keymap.set("n", "[c", function()
				api.node.navigate.git.prev()
				return "0"
			end, opts("Prev Git"))
			vim.keymap.set("n", "]c", function()
				api.node.navigate.git.next()
				return "0"
			end, opts("Next Git"))

			vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
			vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
			vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
			vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
			vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
			vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
			vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
			vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
			vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
			vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
			vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
			vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
			vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
			vim.keymap.set("n", "a", api.fs.create, opts("Create"))
			vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
			vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
			vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
			vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
			vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
			vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
			vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
			vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
			vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
			vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
			vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
			vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
			vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
			vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
			vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
			vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
			vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
			vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
			vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
			vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
			vim.keymap.set("n", "q", api.tree.close, opts("Close"))
			vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
			vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
			vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
			vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
			vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
			vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
			vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
			vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
			vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
			vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
			-- END_DEFAULT_ON_ATTACH

			-- Mappings removed via:
			--   remove_keymaps
			--   OR
			--   view.mappings.list..action = ""
			--
			-- The dummy set before del is done for safety, in case a default mapping does not exist.
			--
			-- You might tidy things by removing these along with their default mapping.
			vim.keymap.set("n", "O", "", { buffer = bufnr })
			vim.keymap.del("n", "O", { buffer = bufnr })
			vim.keymap.set("n", "<2-RightMouse>", "", { buffer = bufnr })
			vim.keymap.del("n", "<2-RightMouse>", { buffer = bufnr })
			vim.keymap.set("n", "D", "", { buffer = bufnr })
			vim.keymap.del("n", "D", { buffer = bufnr })
			vim.keymap.set("n", "E", "", { buffer = bufnr })
			vim.keymap.del("n", "E", { buffer = bufnr })

			-- Mappings migrated from view.mappings.list
			--
			-- You will need to insert "your code goes here" for any mappings with a custom action_cb
			vim.keymap.set("n", "A", api.tree.expand_all, opts("Expand All"))
			vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
			vim.keymap.set("n", "P", function()
				local node = api.tree.get_node_under_cursor()
				print(node.absolute_path)
			end, opts("Print Node Path"))

			vim.keymap.set("n", "Z", api.node.run.system, opts("Run System"))

			return {
				live_filter = {
					prefix = "[FILTER]: ",
					always_show_folders = false,
				},
			}
		end,
	},

	config = function(_, opts)
		require("nvim-tree").setup(opts)
	end,

	keys = {
		{ "<Leader>e", "<Cmd>NvimTreeToggle<CR>", desc = "Nvim-Tree" },
	},
}

return {
	"romgrk/barbar.nvim",

	cond = not vim.g.vscode,

	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},

	opts = {
		-- auto_hide = true,
		icons = { button = false },
	},

	config = function(_, opts)
		vim.keymap.set("n", "<Tab>", "<Cmd>BufferNext<CR>")
		vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>")
		vim.keymap.set("n", "<Leader>q", "<Cmd>BufferClose<CR>")
		vim.keymap.set("n", "<Leader>Q", "<Cmd>BufferClose!<CR>")
		vim.keymap.set("n", "<Leader>t", "<Cmd>enew<CR>")
		vim.keymap.set("n", "<Leader>T", "<Cmd>BufferRestore<CR>")
		vim.keymap.set("n", "<M-1>", "<Cmd>BufferGoto 1<CR>")
		vim.keymap.set("n", "<M-2>", "<Cmd>BufferGoto 2<CR>")
		vim.keymap.set("n", "<M-3>", "<Cmd>BufferGoto 3<CR>")
		vim.keymap.set("n", "<M-4>", "<Cmd>BufferGoto 4<CR>")
		vim.keymap.set("n", "<M-5>", "<Cmd>BufferGoto 5<CR>")
		vim.keymap.set("n", "<M-6>", "<Cmd>BufferGoto 6<CR>")
		vim.keymap.set("n", "<M-7>", "<Cmd>BufferGoto 7<CR>")
		vim.keymap.set("n", "<M-8>", "<Cmd>BufferGoto 8<CR>")
		vim.keymap.set("n", "<M-9>", "<Cmd>BufferGoto 9<CR>")
		vim.keymap.set("n", "<M-0>", "<Cmd>BufferLast<CR>")
		vim.keymap.set("n", "<Leader><Tab>", "<Cmd>BufferMoveNext<CR>")
		vim.keymap.set("n", "<Leader><S-Tab>", "<Cmd>BufferMovePrevious<CR>")
		vim.keymap.set("n", "g<Tab>", "<Cmd>BufferPick<CR>")
		vim.keymap.set("n", "g<S-Tab>", "<Cmd>BufferPin<CR>")

		require("barbar").setup(opts)
	end,
}

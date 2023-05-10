return {
	"romgrk/barbar.nvim",

	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},

	opts = {
		auto_hide = true,
		icons = { button = false },
	},

	config = function(_, opts)
		local set = vim.keymap.set

		set("n", "<Tab>", "<Cmd>BufferNext<CR>")
		set("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>")
		set("n", "<Leader>q", "<Cmd>BufferClose<CR>")
		set("n", "<Leader>Q", "<Cmd>BufferClose!<CR>")
		set("n", "<C-t>", "<Cmd>enew<CR>")
		set("n", "<Leader><C-t>", "<Cmd>BufferRestore<CR>")
		set("n", "<M-1>", "<Cmd>BufferGoto 1<CR>")
		set("n", "<M-2>", "<Cmd>BufferGoto 2<CR>")
		set("n", "<M-3>", "<Cmd>BufferGoto 3<CR>")
		set("n", "<M-4>", "<Cmd>BufferGoto 4<CR>")
		set("n", "<M-5>", "<Cmd>BufferGoto 5<CR>")
		set("n", "<M-6>", "<Cmd>BufferGoto 6<CR>")
		set("n", "<M-7>", "<Cmd>BufferGoto 7<CR>")
		set("n", "<M-8>", "<Cmd>BufferGoto 8<CR>")
		set("n", "<M-9>", "<Cmd>BufferGoto 9<CR>")
		set("n", "<M-0>", "<Cmd>BufferLast<CR>")
		set("n", "<Leader><Tab>", "<Cmd>BufferMoveNext<CR>")
		set("n", "<Leader><S-Tab>", "<Cmd>BufferMovePrevious<CR>")
		set("n", "g<Tab>", "<Cmd>BufferPick<CR>")
		set("n", "g<S-Tab>", "<Cmd>BufferPin<CR>")

		require("barbar").setup(opts)
	end,

	event = "VeryLazy",
}

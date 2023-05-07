return {
	"Mofiqul/dracula.nvim",

	config = function()
		vim.cmd([[colorscheme dracula]])

		vim.cmd([[highlight IndentBlanklineIndent guifg=#44475a gui=nocombine]])
	end,
}

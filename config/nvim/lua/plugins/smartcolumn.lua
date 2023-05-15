return {
	"m4xshen/smartcolumn.nvim",

	cond = not vim.g.vscode,

	opts = {
		colorcolumn = nil,
		custom_colorcolumn = {
			python = { 72, 79 },
		},
	},
}

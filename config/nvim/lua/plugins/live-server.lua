return {
	"barrett-ruth/live-server.nvim",

	cond = not vim.g.vscode,

	config = true,

	-- build = "sudo npm install -g live-server",

	event = "VeryLazy",
}

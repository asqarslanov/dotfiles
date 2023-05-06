---@type ChadrcConfig

local M = {}

M.ui = {
	theme = "chadracula",
	nvdash = {
		load_on_startup = true,
		header = {
			"                                                     ",
			" ███╗   ██╗██╗   ██╗ ██████╗██╗  ██╗ █████╗ ██████╗  ",
			" ████╗  ██║██║   ██║██╔════╝██║  ██║██╔══██╗██╔══██╗ ",
			" ██╔██╗ ██║██║   ██║██║     ███████║███████║██║  ██║ ",
			" ██║╚██╗██║╚██╗ ██╔╝██║     ██╔══██║██╔══██║██║  ██║ ",
			" ██║ ╚████║ ╚████╔╝ ╚██████╗██║  ██║██║  ██║██████╔╝ ",
			" ╚═╝  ╚═══╝  ╚═══╝   ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝  ",
			"                                                     ",
			"                                                     ",
			"          k - Up            I use Nvim, BTW        ",
			"          j - Down          Return - Select        ",
		},

		buttons = {
			{ "󰇚  Update", "...", "NvChadUpdate" },
			{ "󰋖  Mappngs", "Space ?", "NvCheatsheet" },
			{ "󱎘  Quit", "Space q", "q" },
		},
	},
}

M.mappings = require("custom.mappings")
M.plugins = "custom.plugins"

return M

return {
	"goolord/alpha-nvim",

	cond = not vim.g.vscode,

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	opts = function()
		local function capture(command)
			local handle = assert(io.popen(command, "r"))
			local output = assert(handle:read("*a"))

			handle:close()

			output = string.gsub(output, "^%s+", "")
			output = string.gsub(output, "%s+$", "")
			output = string.gsub(output, "[\n\r]+", " ")

			return output
		end

		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			[[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
			[[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
			[[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
			[[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
			[[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
			[[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
		}

		dashboard.section.buttons.val = {
			dashboard.button("n", "+  New File", "<Cmd>enew<CR>"),
			dashboard.button("u", "!  Update", "<Cmd>Lazy sync<CR>"),
			dashboard.button("q", "x  Quit", "<Cmd>quitall<CR>"),
		}

		dashboard.section.footer.val = {
			capture("fortune -s"),
		}

		return dashboard.config
	end,
}

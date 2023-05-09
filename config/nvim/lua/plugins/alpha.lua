return {
	"goolord/alpha-nvim",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	opts = function()
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			[[      .            .      ]],
			[[    .,;'           :,.    ]],
			[[  .,;;;,,.         ccc;.  ]],
			[[.;c::::,,,'        ccccc: ]],
			[[.::cc::,,,,,.      cccccc.]],
			[[.cccccc;;;;;;'     llllll.]],
			[[.cccccc.,;;;;;;.   llllll.]],
			[[.cccccc  ';;;;;;'  oooooo.]],
			[['lllllc   .;;;;;;;.oooooo']],
			[['lllllc     ,::::::looooo']],
			[['llllll      .:::::lloddd']],
			[['looool       .;::coooodo.]],
			[[  .cool         'ccoooc.  ]],
			[[    .co          .:o:.    ]],
			[[      .           .'      ]],
			-- [[       test                    __                ]],
			-- [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
			-- [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
			-- [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
			-- [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
			-- [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
		}

		dashboard.section.buttons.val = {
			dashboard.button("e", "  New File", "<Cmd>enew|startinsert<CR>"),
			dashboard.button("q", "  Quit", "<Cmd>quitall<CR>"),
		}

		return dashboard.config
	end,
}

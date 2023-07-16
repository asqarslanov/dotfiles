return {
	"phaazon/hop.nvim",

	config = function()
		local hop = require("hop")

		local set = vim.keymap.set

		set("n", "gf", hop.hint_char1)
		set("n", "gF", hop.hint_words)
		set("n", "gt", function()
			hop.hint_char1({ hint_offset = -1 })
		end)
		set("n", "gT", function()
			hop.hint_char1({ hint_offset = 1 })
		end)
		set("n", "g/", hop.hint_patterns)

		hop.setup()
	end,

	keys = { "gf", "gF", "gt", "gT", "g/" },
}

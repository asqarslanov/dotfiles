return {
	"phaazon/hop.nvim",

	config = true,

	keys = function()
		local hop = require("hop")

		return {
			{
				"gf",
				hop.hint_char1,
			},
			{
				"gF",
				hop.hint_words,
			},
			{
				"gt",
				function()
					hop.hint_char1({ hint_offset = -1 })
				end,
			},
			{
				"gT",
				function()
					hop.hint_char1({ hint_offset = 1 })
				end,
			},
			{
				"g/",
				hop.hint_patterns,
			},
		}
	end,
}

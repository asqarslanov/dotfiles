local M = {}

M.General = {
	i = {
		["<C-Backspace>"] = { "<C-w>", "Erase Word Before" },
		["<C-a>"] = { "<Esc>I", "Beginning of Line" },
	},
	n = {
		["<Esc>"] = { "<Cmd>noh<CR>", "Clear Highlights" },
		["<Leader>?"] = { "<Cmd>NvCheatsheet<CR>", "Cheat Sheet" },
		["<Leader>Q"] = { "<Cmd>qall<CR>", "Forced Quit" },
		["<Leader>V"] = { "ggVG", "Select All Lines" },
		["<Leader>W"] = { "<Cmd>w<CR>", "Write Without Formatting" },
		["<Leader>q"] = { "<Cmd>q<CR>", "Quit" },
		["<Leader>v"] = { "gg0vG$", "Select All" },
		["<Leader>w"] = { "<Cmd>Neoformat|w<CR>", "Write and Format" },
	},
	v = {
		["<Leader>V"] = { "<Esc>ggVG", "Select All Lines" },
		["<Leader>v"] = { "<ESC>gg0vG$", "Select All" },
	},
}

M.Clipboard = {
	n = {
		["<Leader>C"] = { '"+C', "Change Rest" },
		["<Leader>D"] = { '"+D', "Delete Rest" },
		["<Leader>P"] = { '"+P', "Paste Before" },
		["<Leader>S"] = { '"+S', "Substitute Line" },
		["<Leader>X"] = { '"+X', "Delete Before" },
		["<Leader>Y"] = { '"+Y', "Yank Line" },
		["<Leader>c"] = { '"+c', "Change + ..." },
		["<Leader>d"] = { '"+d', "Cut + ..." },
		["<Leader>p"] = { '"+p', "Paste After" },
		["<Leader>s"] = { '"+s', "Substitute" },
		["<Leader>x"] = { '"+x', "Cut Char" },
		["<Leader>y"] = { '"+y', "Yank + ..." },
	},
	v = {
		["<Leader>C"] = { '"+C', "Change Line" },
		["<Leader>D"] = { '"+D', "Delete Line" },
		["<Leader>P"] = { '"+P', "Paste Instead" },
		["<Leader>S"] = { '"+S', "Substitute Line" },
		["<Leader>X"] = { '"+X', "Cut Line" },
		["<Leader>Y"] = { '"+Y', "Yank Line" },
		["<Leader>c"] = { '"+c', "Change Selection" },
		["<Leader>d"] = { '"+d', "Delete Selection" },
		["<Leader>p"] = { '"+p', "Paste Instead" },
		["<Leader>s"] = { '"+s', "Substitute Selection" },
		["<Leader>x"] = { '"+x', "Cut Selection" },
		["<Leader>y"] = { '"+y', "Yank Selection" },
	},
}

M.disabled = {
	n = {
		["<leader>D"] = "",
		["<leader>ch"] = "",
		["<leader>ph"] = "",
		["<leader>pt"] = "",
		["<leader>q"] = "",
		["<leader>v"] = "",
		["<leader>wK"] = "",
		["<leader>wa"] = "",
		["<leader>wk"] = "",
		["<leader>wl"] = "",
		["<leader>wr"] = "",
		["<leader>x"] = "",
	},
}

return M

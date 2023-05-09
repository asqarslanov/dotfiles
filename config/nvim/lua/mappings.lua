vim.g.mapleader = " "

local keymap = vim.keymap

-- indentscope
-- surround
-- comment
-- terminal
-- color-picker

keymap.set("n", "j", "gj")
keymap.set("n", "k", "gk")

keymap.set("i", "<C-a>", "<Esc>I")
keymap.set("i", "<C-e>", "<Esc>A")
keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-j>", "<C-o>gj")
keymap.set("i", "<C-k>", "<C-o>gk")
keymap.set("i", "<C-l>", "<Right>")

keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")
-- keymap.set("n", "<Leader>?", "<Cmd>NvCheatsheet<CR>")
keymap.set("n", "<Leader>Q", "<Cmd>qall<CR>")
keymap.set("n", "<Leader>V", "ggVG")
keymap.set("n", "<Leader>W", "<Cmd>w<CR>")
keymap.set("n", "<Leader>q", "<Cmd>q<CR>")
keymap.set("n", "<Leader>v", "gg0vG$")
keymap.set("n", "<Leader>w", "<Cmd>Neoformat|w<CR>")

keymap.set("v", "<Leader>V", "<Esc>ggVG")
keymap.set("v", "<Leader>v", "<ESC>gg0vG$")

keymap.set("n", "<C-s>", "<Cmd>Neoformat|w<CR>")
keymap.set("i", "<C-s>", "<Cmd>Neoformat|w<CR>")
-- keymap.set("n", "<C-w>", function() require("nvchad_ui.tabufline").close_buffer() end)

keymap.set("n", "<Leader>C", '"+C')
keymap.set("n", "<Leader>D", '"+D')
keymap.set("n", "<Leader>P", '"+P')
keymap.set("n", "<Leader>S", '"+S')
keymap.set("n", "<Leader>X", '"+X')
keymap.set("n", "<Leader>Y", '"+Y')
keymap.set("n", "<Leader>c", '"+c')
keymap.set("n", "<Leader>d", '"+d')
keymap.set("n", "<Leader>p", '"+p')
keymap.set("n", "<Leader>s", '"+s')
keymap.set("n", "<Leader>x", '"+x')
keymap.set("n", "<Leader>y", '"+y')

keymap.set("v", "<Leader>C", '"+C')
keymap.set("v", "<Leader>D", '"+D')
keymap.set("v", "<Leader>P", '"+P')
keymap.set("v", "<Leader>S", '"+S')
keymap.set("v", "<Leader>X", '"+X')
keymap.set("v", "<Leader>Y", '"+Y')
keymap.set("v", "<Leader>c", '"+c')
keymap.set("v", "<Leader>d", '"+d')
keymap.set("v", "<Leader>p", '"+p')
keymap.set("v", "<Leader>s", '"+s')
keymap.set("v", "<Leader>x", '"+x')
keymap.set("v", "<Leader>y", '"+y')

keymap.set("i", "<C-Backspace>", "<C-w>")

keymap.set("i", "<A-CR>", "<C-o>:set wrap!<CR>")
keymap.set("n", "<A-CR>", ":set wrap!<CR>")

keymap.set("n", "<C-h>", "<C-W>h")
keymap.set("n", "<C-j>", "<C-W>j")
keymap.set("n", "<C-k>", "<C-W>k")
keymap.set("n", "<C-l>", "<C-W>l")

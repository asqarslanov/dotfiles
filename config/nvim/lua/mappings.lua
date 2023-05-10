vim.g.mapleader = " "

local set = vim.keymap.set

-- indentscope
-- surround
-- comment
-- terminal
-- tab bar
-- color-picker

set("n", "j", "gj")
set("n", "k", "gk")

set("i", "<C-a>", "<Esc>I")
set("i", "<C-e>", "<Esc>A")
set("i", "<C-h>", "<Left>")
set("i", "<C-j>", "<C-o>gj")
set("i", "<C-k>", "<C-o>gk")
set("i", "<C-l>", "<Right>")

set("n", "<Esc>", "<Cmd>nohlsearch<CR>")
-- set("n", "<Leader>?", "<Cmd>NvCheatsheet<CR>")
set("n", "<Leader><C-q>", "<Cmd>quitall<CR>")
set("n", "<Leader>V", "ggVG")
set("n", "<C-q>", "<Cmd>quit<CR>")
set("n", "<Leader>v", "gg0vG$")

set("v", "<Leader>V", "<Esc>ggVG")
set("v", "<Leader>v", "<ESC>gg0vG$")

set("n", "<C-s>", "<Cmd>Neoformat|write<CR>")
set("n", "<C-S>", "<Cmd>write<CR>")
set("n", "<Leader>w", "<Cmd>Neoformat|write<CR>")
set("n", "<Leader>W", "<Cmd>write<CR>")

set("n", "<Leader>C", '"+C')
set("n", "<Leader>D", '"+D')
set("n", "<Leader>P", '"+P')
set("n", "<Leader>S", '"+S')
set("n", "<Leader>X", '"+X')
set("n", "<Leader>Y", '"+Y')
set("n", "<Leader>c", '"+c')
set("n", "<Leader>d", '"+d')
set("n", "<Leader>p", '"+p')
set("n", "<Leader>s", '"+s')
set("n", "<Leader>x", '"+x')
set("n", "<Leader>y", '"+y')

set("v", "<Leader>C", '"+C')
set("v", "<Leader>D", '"+D')
set("v", "<Leader>P", '"+P')
set("v", "<Leader>S", '"+S')
set("v", "<Leader>X", '"+X')
set("v", "<Leader>Y", '"+Y')
set("v", "<Leader>c", '"+c')
set("v", "<Leader>d", '"+d')
set("v", "<Leader>p", '"+p')
set("v", "<Leader>s", '"+s')
set("v", "<Leader>x", '"+x')
set("v", "<Leader>y", '"+y')

set("i", "<A-CR>", "<C-o>:set wrap!<CR>")
set("n", "<A-CR>", ":set wrap!<CR>")

set("n", "<C-h>", "<C-W>h")
set("n", "<C-j>", "<C-W>j")
set("n", "<C-k>", "<C-W>k")
set("n", "<C-l>", "<C-W>l")

vim.g.mapleader = " "

-- indentscope
-- surround
-- comment
-- terminal
-- tab bar
-- color-picker

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

vim.keymap.set("i", "<C-a>", "<Esc>I")
vim.keymap.set("i", "<C-b>", "<Left>")
vim.keymap.set("i", "<C-e>", "<Esc>A")
vim.keymap.set("i", "<C-f>", "<Right>")
vim.keymap.set("i", "<C-n>", "<C-o>gj")
vim.keymap.set("i", "<C-p>", "<C-o>gk")
vim.keymap.set("i", "<C-t>", "<Esc>Xpa")
vim.keymap.set("i", "<M-b>", "<C-o>b")
vim.keymap.set("i", "<M-f>", "<C-o>w")

vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")
-- vim.keymap.set("n", "<Leader>?", "<Cmd>NvCheatsheet<CR>")
vim.keymap.set("n", "<Leader><C-q>", "<Cmd>quitall<CR>")
vim.keymap.set("n", "<Leader>V", "ggVG")
vim.keymap.set("n", "<C-q>", "<Cmd>quit<CR>")
vim.keymap.set("n", "<Leader>v", "gg0vG$")

vim.keymap.set("v", "<Leader>V", "<Esc>ggVG")
vim.keymap.set("v", "<Leader>v", "<ESC>gg0vG$")

vim.keymap.set("n", "<C-s>", "<Cmd>Neoformat|write<CR>")
vim.keymap.set("n", "<C-S>", "<Cmd>write<CR>")
vim.keymap.set("n", "<Leader>w", "<Cmd>Neoformat|write<CR>")
vim.keymap.set("n", "<Leader>W", "<Cmd>write<CR>")

vim.keymap.set("n", "<Leader>C", '"+C')
vim.keymap.set("n", "<Leader>D", '"+D')
vim.keymap.set("n", "<Leader>P", '"+P')
vim.keymap.set("n", "<Leader>S", '"+S')
vim.keymap.set("n", "<Leader>X", '"+X')
vim.keymap.set("n", "<Leader>Y", '"+Y')
vim.keymap.set("n", "<Leader>c", '"+c')
vim.keymap.set("n", "<Leader>d", '"+d')
vim.keymap.set("n", "<Leader>p", '"+p')
vim.keymap.set("n", "<Leader>s", '"+s')
vim.keymap.set("n", "<Leader>x", '"+x')
vim.keymap.set("n", "<Leader>y", '"+y')

vim.keymap.set("v", "<Leader>C", '"+C')
vim.keymap.set("v", "<Leader>D", '"+D')
vim.keymap.set("v", "<Leader>P", '"+P')
vim.keymap.set("v", "<Leader>S", '"+S')
vim.keymap.set("v", "<Leader>X", '"+X')
vim.keymap.set("v", "<Leader>Y", '"+Y')
vim.keymap.set("v", "<Leader>c", '"+c')
vim.keymap.set("v", "<Leader>d", '"+d')
vim.keymap.set("v", "<Leader>p", '"+p')
vim.keymap.set("v", "<Leader>s", '"+s')
vim.keymap.set("v", "<Leader>x", '"+x')
vim.keymap.set("v", "<Leader>y", '"+y')

vim.keymap.set("n", "<A-CR>", "<Cmd>set wrap!<CR>")

vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-l>", "<C-W>l")

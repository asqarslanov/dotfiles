vim.g.mapleader = ' '

vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-l>', '<Right>')

vim.keymap.set('n', '<leader>P', '"+P')
vim.keymap.set('n', '<leader>Y', '"+Y')
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>P', '"+P')
vim.keymap.set('v', '<leader>Y', '"+Y')
vim.keymap.set('v', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>y', '"+y')

vim.keymap.set('i', '<C-s>', '<C-o>:w<Enter>')
vim.keymap.set('n', '<C-s>', ':w<Enter>')

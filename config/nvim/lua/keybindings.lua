vim.g.mapleader = ' '

vim.opt.whichwrap:append('<')
vim.opt.whichwrap:append('>')
vim.opt.whichwrap:append('h')
vim.opt.whichwrap:append('l')

vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-l>', '<Right>')

vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==')
vim.keymap.set('v', '<A-j>', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', '<A-k>', ':m \'<-2<CR>gv=gv')

vim.keymap.set('n', '<leader>V', 'ggVG')
vim.keymap.set('n', '<leader>v', 'gg0vG$')
vim.keymap.set('v', '<leader>V', '<Esc>ggVG')
vim.keymap.set('v', '<leader>v', '<Esc>gg0vG$')

vim.keymap.set('n', '<leader>Y', '"+Y')
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>Y', '"+Y')
vim.keymap.set('v', '<leader>y', '"+y')

vim.keymap.set('n', '<leader>P', '"+P')
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>P', '"+P')
vim.keymap.set('v', '<leader>p', '"+p')

vim.keymap.set('i', '<C-w>', '<C-o>:q<Enter>')
vim.keymap.set('n', '<C-w>', ':q<Enter>')

vim.keymap.set('i', '<C-s>', '<C-o>:w<Enter>')
vim.keymap.set('n', '<C-s>', ':w<Enter>')

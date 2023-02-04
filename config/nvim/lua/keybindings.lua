vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>l', ':w<CR>:!lua %<CR>')

vim.opt.whichwrap:append('<')
vim.opt.whichwrap:append('>')
vim.opt.whichwrap:append('h')
vim.opt.whichwrap:append('l')

vim.keymap.set('n', '<C-w>', ':q<CR>')
vim.keymap.set('v', '<C-w>', ':<C-w>q<CR>')

vim.keymap.set('i', '<C-e>', '<Esc>A')
vim.keymap.set('i', '<C-a>', '<Esc>I')

vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-l>', '<Right>')

vim.keymap.set('n', '<C-h>', '<C-W>h')
vim.keymap.set('n', '<C-j>', '<C-W>j')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-l>', '<C-W>l')

vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==:lua print("Line Moved Down")<CR>')
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==:lua print("Line Moved Up")<CR>')
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

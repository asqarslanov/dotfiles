vim.g.mapleader = ' '

vim.keymap.set('n', '<C-s>', ':q<CR>')
vim.keymap.set('v', '<C-s>', ':<C-w>q<CR>')
vim.keymap.set('n', '<Leader>w', ':w<CR>')

vim.keymap.set('i', '<C-Backspace>', '<C-w>')

vim.keymap.set('n', '<Leader>w', ':Neoformat<CR>:w<CR>')

vim.keymap.set('i', '<A-CR>', '<C-o>:set wrap!<CR>')
vim.keymap.set('n', '<A-CR>', ':set wrap!<CR>')

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

vim.keymap.set('n', '<Leader>V', 'ggVG')
vim.keymap.set('n', '<Leader>v', 'gg0vG$')
vim.keymap.set('v', '<Leader>V', '<Esc>ggVG')
vim.keymap.set('v', '<Leader>v', '<Esc>gg0vG$')

vim.keymap.set('n', '<Leader>Y', '"+Y')
vim.keymap.set('n', '<Leader>y', '"+y')
vim.keymap.set('v', '<Leader>Y', '"+Y')
vim.keymap.set('v', '<Leader>y', '"+y')

vim.keymap.set('n', '<Leader>P', '"+P')
vim.keymap.set('n', '<Leader>p', '"+p')
vim.keymap.set('v', '<Leader>P', '"+P')
vim.keymap.set('v', '<Leader>p', '"+p')

vim.keymap.set('n', '<Leader>D', '"+D')
vim.keymap.set('n', '<Leader>d', '"+d')
vim.keymap.set('v', '<Leader>D', '"+D')
vim.keymap.set('v', '<Leader>d', '"+d')

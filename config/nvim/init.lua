local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '

require('lazy').setup({
    {
        'declancm/cinnamon.nvim',
        config = function()
            require('cinnamon').setup {
                extended_keymaps = true,
                extra_keymaps = true
            }
        end
    },
    {
        'glacambre/firenvim',
        build = function()
            vim.fn['firenvim#install'](0)
        end,
        cond = not not vim.g.started_by_firenvim
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim'
        },
        config = function()
            require('mason').setup()
            require('mason-lspconfig').setup {
                ensure_installed = {
                    'html',
                    'rust_analyzer',
                    'sumneko_lua',
                }
            }
        end
    },
    {
        'petertriho/nvim-scrollbar',
        config = true
    },
    {
        'kylechui/nvim-surround',
        config = true
    },
    {
        'AlphaTechnolog/pywal.nvim',
        config = true
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        end
    },


    --[[
    {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require('which-key').setup { }
        end
    },
    {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
    },
    --]]
})


vim.opt.confirm = true
vim.opt.expandtab = true
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars = {tab = "→  ", trail = "·"}
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.smartcase = true
vim.opt.tabstop = 4

vim.opt.whichwrap:append('<')
vim.opt.whichwrap:append('>')
vim.opt.whichwrap:append('h')
vim.opt.whichwrap:append('l')

-- vim.keymap.set('n', '<C-w>', ':q<CR>')
-- vim.keymap.set('v', '<C-w>', ':<C-w>q<CR>')
vim.keymap.set('n', '<Leader>w', ':w<CR>')

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

return {
    {
        'RRethy/vim-illuminate'
    },
    {
        'numToStr/Comment.nvim',
        config = true
    },
    {
        'glacambre/firenvim',
        build = function()
            vim.fn['firenvim#install'](0)
        end,
        cond = not not vim.g.started_by_firenvim
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require 'indent_blankline' .setup {
                char_highlight_list = {
                    'IndentBlanklineIndent1',
                    'IndentBlanklineIndent4',
                },
                show_current_context = true,
                show_current_context_start = true,
                use_treesitter = true
            }
        end
    },
    {
        'barrett-ruth/live-server.nvim',
        build = 'npm install -g live-server',
        config = true
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim'
        },
        config = function()
            require 'mason' .setup()
            require 'mason-lspconfig' .setup {
                ensure_installed = {
                    'html',
                    'rust_analyzer',
                    -- 'sumneko_lua',
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
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require 'nvim-treesitter.configs' .setup {
                ensure_installed = {
                    'bash',
                    'cpp',
                    'css',
                    'gitignore',
                    'html',
                    'javascript',
                    'lua',
                    'markdown',
                    'python',
                    'rust'
                }
            }
        end
    },
    {
        'eraserhd/parinfer-rust',
        build = 'cargo build --release'
    },
    {
        'AlphaTechnolog/pywal.nvim',
        config = function()
            require 'pywal' .setup()
            local color_scheme = require 'pywal.core' .get_colors()

            for i = 1, 6 do
                vim.api.nvim_set_hl(
                    0,
                    'IndentBlankLineIndent' .. i,
                    {
                        fg=color_scheme['color' .. i],
                        nocombine=true
                    }
                )
            end
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            local builtin = require 'telescope.builtin'
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        end
    },
    {
        'elkowar/yuck.vim'
    },
    --[[
    {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require 'which-key' .setup { }
        end
    },
    --]]
}

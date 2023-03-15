return {
    -- {
    --     'RRethy/vim-illuminate'
    -- },
    {
        'lukas-reineke/cmp-under-comparator'
    },
    {
        'numToStr/Comment.nvim',
        config = true
    },
    {
        'Mofiqul/dracula.nvim',
        config = function()
            vim.cmd[[colorscheme dracula]]
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
        'windwp/nvim-autopairs',
        config = true
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-cmdline',
            'dmitmel/cmp-digraphs',
            'hrsh7th/cmp-emoji',
            'chrisgrieser/cmp-nerdfont',
            'kdheepak/cmp-latex-symbols',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-path',
            'andersevenrud/cmp-tmux',
            'onsails/lspkind.nvim',
            'amarakon/nvim-cmp-fonts',
            'neovim/nvim-lspconfig'
        },
        config = function()
            local cmp = require 'cmp'
            local lspkind = require 'lspkind'
            cmp.setup({
                formatting = {
                    format = lspkind.cmp_format {
                        ellipsis_char = '…'
                    }
                },
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm()
                },
                sources = cmp.config.sources({
                    { name = 'calc' },
                    { name = 'digraphs' },
                    { name = 'emoji' },
                    { name = 'fonts' },
                    { name = 'latex_symbols' },
                    { name = 'nerdfont' },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'nvim_lua' },
                    { name = 'path' },
                    { name = 'tmux' }
                    -- { name = 'vsnip' }, -- For vsnip users.
                    -- { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                }, {
                    { name = 'buffer' },
                }),
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        require 'cmp-under-comparator'.under,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order
                    }
                }
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
                }, {
                    { name = 'buffer' },
                })
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })

            -- Set up lspconfig.
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
            -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
            --     capabilities = capabilities
            -- }
        end
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
        dependencies = {
            'windwp/nvim-ts-autotag',
            'HiPhish/nvim-ts-rainbow2'
        },
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
                },
                autotag = {
                    enable = true
                },
                rainbow = {
                    enable = true,
                    extended_mode = true
                }
            }
        end
    },
    {
        'eraserhd/parinfer-rust',
        build = 'cargo build --release'
    },
    -- {
    --     'AlphaTechnolog/pywal.nvim',
    --     config = function()
    --         require 'pywal' .setup()
    --         local color_scheme = require 'pywal.core' .get_colors()
    --
    --         for i = 1, 6 do
    --             vim.api.nvim_set_hl(
    --                 0,
    --                 'IndentBlankLineIndent' .. i,
    --                 {
    --                     fg=color_scheme['color' .. i],
    --                     nocombine=true
    --                 }
    --             )
    --         end
    --     end
    -- },
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

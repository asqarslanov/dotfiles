return {
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
        'VonHeikemen/fine-cmdline.nvim',
        dependencies = {
            'MunifTanjim/nui.nvim'
        },
        config = function()
            vim.keymap.set('n', '<CR>', '<cmd>FineCmdline<CR>')
            vim.keymap.set('v', '<CR>', '<cmd>FineCmdline \'<,\'><CR>')
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
        'phaazon/hop.nvim',
        config = function()
            local hop = require 'hop'

            vim.keymap.set('', 'gf', hop.hint_char1)
            vim.keymap.set('', 'gF', hop.hint_words)
            vim.keymap.set('', 'gt', function() hop.hint_char1 { hint_offset = -1 } end)
            vim.keymap.set('', 'gT', function() hop.hint_char1 { hint_offset = 1 } end)
            vim.keymap.set('', 'g/', hop.hint_patterns)

            hop.setup()
        end
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
        build = 'sudo npm install -g live-server',
        config = true
    },
    'sbdchd/neoformat',
    {
        'windwp/nvim-autopairs',
        config = true
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-emoji',
            'chrisgrieser/cmp-nerdfont',
            'kdheepak/cmp-latex-symbols',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-path',
            'andersevenrud/cmp-tmux',
            'lukas-reineke/cmp-under-comparator',
            'onsails/lspkind.nvim',
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
                    { name = 'emoji' },
                    { name = 'latex_symbols' },
                    { name = 'nerdfont' },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'path' },
                    { name = 'tmux' }
                    -- { name = 'vsnip' }, -- For vsnip users.
                    -- { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                }, {
                    { name = 'buffer' },
                }),
                -- sorting = {
                --     comparators = {
                --         cmp.config.compare.offset,
                --         cmp.config.compare.exact,
                --         cmp.config.compare.score,
                --         require 'cmp-under-comparator'.under,
                --         cmp.config.compare.kind,
                --         cmp.config.compare.sort_text,
                --         cmp.config.compare.length,
                --         cmp.config.compare.order
                --     }
                -- }
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
                sources = cmp.config.sources(
                    { { name = 'path' } },
                    { { name = 'cmdline' } }
                )
            })
        end
    },
    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require 'dap'

            dap.adapters.python = {
                type = 'executable',
                command = 'python3',
                args = { '-m', 'debugpy.adapter' }
            }
            dap.configurations.python = {
                {
                    -- The first three options are required by nvim-dap
                    type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
                    request = 'launch',
                    name = "Launch file",

                    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

                    program = "${file}",  -- This configuration will launch the current file if used.
                    pythonPath = function()
                        -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                        -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                        -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                        local cwd = vim.fn.getcwd()
                        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                            return cwd .. '/venv/bin/python'
                        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                            return cwd .. '/.venv/bin/python'
                        else
                            return '/usr/bin/python'
                        end
                    end
                }
            }
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
                    'bashls',
                    'clangd',
                    'html',
                    'jsonls',
                    'lua_ls',
                    'pyright',
                    'rust_analyzer'
                }
            }

            local lspconfig = require('lspconfig')
            lspconfig.bashls.setup {}
            lspconfig.clangd.setup {}
            lspconfig.html.setup {}
            lspconfig.jsonls.setup {}
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            }
            lspconfig.pyright.setup {}
            lspconfig.rust_analyzer.setup {}

            -- lspconfig.lua_ls.setup()
            -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- The following example advertise capabilities to `clangd`.
            require 'lspconfig' .clangd.setup {
                capabilities = capabilities
            }
        end
    },
    { 'petertriho/nvim-scrollbar', config = true },
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
                    'json',
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
    -- {
    --     'eraserhd/parinfer-rust',
    --     build = 'cargo build --release'
    -- },
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
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = true
    },
    {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
            local wk = require 'which-key'
            wk.register {
                ['<leader>'] = {
                    D = 'Cut Rest to Clipboard',
                    P = 'Paste Before from Clipboard',
                    V = 'Select All Lines',
                    Y = 'Copy Line to Clipboard',
                    d = 'Cut to Clipboard...',
                    p = 'Paste After from Clipboard',
                    q = 'Quit',
                    v = 'Select All',
                    w = 'Format and Save',
                    y = 'Copy to Clipboard...',
                }
            }
            require 'which-key' .setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end,
    },
}

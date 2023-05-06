local plugins = {
    {
        'williamboman/mason.nvim',
        opts = {
            ensure_installed = {
                'bash-language-server',
                'html-lsp',
                'json-lsp',
                'lua-language-server',
                'pyright',
                'rustfmt',
                'shfmt',
                'stylua',
                -- 'clangd',
                -- 'rust-analyzer',
            },
        },
    },
    {
        'echasnovski/mini.move',
        lazy = false,
        config = function()
            require('mini.move').setup()
        end,
    },
    {
        'echasnovski/mini.surround',
        lazy = false,
        config = function()
            require('mini.surround').setup()
        end,
    },
    {
        'sbdchd/neoformat',
        lazy = false,
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require 'plugins.configs.lspconfig'
            require 'custom.configs.lspconfig'
        end,
    },
    {
        'mfussenegger/nvim-dap',
    },
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            ensure_installed = {
                'bash',
                'comment',
                'cpp',
                'css',
                'diff',
                'git_config',
                'git_rebase',
                'gitattributes',
                'gitcommit',
                'gitignore',
                'html',
                'ini',
                'json',
                'json5',
                'jsonc',
                'lua',
                'luap',
                'markdown',
                'markdown_inline',
                'python',
                'regex',
                'toml',
                'yaml',
                -- 'c',
                -- 'c_sharp',
                -- 'cmake',
                -- 'dockerfile',
                -- 'http',
                -- 'javascript',
                -- 'jq',
                -- 'latex',
                -- 'make',
                -- 'rust',
                -- 'typescript',
            },
        },
    },
    {
        'folke/which-key.nvim',
        enabled = false,
    },
}

return plugins

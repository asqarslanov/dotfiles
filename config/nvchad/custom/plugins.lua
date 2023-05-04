local plugins = {
    {
        'williamboman/mason.nvim',
        opts = {
            ensure_installed = {
                'bash-language-server',
                -- 'clangd',
                'html-lsp',
                'json-lsp',
                'lua-language-server',
                'pyright',
                'rust-analyzer'
            }
        }
    },
    {
        'echasnovski/mini.move',
        lazy = false,
        config = function()
            require 'mini.move' .setup()
        end
    },
    {
        'echasnovski/mini.surround',
        lazy = false,
        config = function()
            require 'mini.surround' .setup()
        end
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require 'plugins.configs.lspconfig'
            require 'custom.configs.lspconfig'
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            ensure_installed = {
                'bash',
                -- 'c',
                -- 'c_sharp',
                -- 'cmake',
                'comment',
                'cpp',
                'css',
                'diff',
                -- 'dockerfile',
                'git_config',
                'git_rebase',
                'gitattributes',
                'gitcommit',
                'gitignore',
                'html',
                -- 'http',
                'ini',
                -- 'javascript',
                -- 'jq',
                'json',
                'json5',
                'jsonc',
                -- 'latex',
                'lua',
                'luap',
                -- 'make',
                'markdown',
                'markdown_inline',
                'python',
                'regex',
                'rust',
                'toml',
                -- 'typescript',
                'yaml'
            }
        }
    }
}

return plugins

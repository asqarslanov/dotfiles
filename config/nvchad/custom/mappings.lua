local M = {}

M.general = {
    i = {
        ['<C-Backspace>'] = { '<C-w>', 'erase word before' },
        ['<C-a>'] = { '<Esc>I', 'beginning of line' },
    },
    n = {
        ['<Esc>'] = { '<Cmd>noh<CR>', 'clear highlights' },
        ['<Leader>?'] = { '<Cmd>NvCheatsheet<CR>', 'cheatsheet' },
        ['<Leader>Q'] = { '<Cmd>qall<CR>', 'quit' },
        ['<Leader>V'] = { 'ggVG', 'select all lines' },
        ['<Leader>q'] = { '<Cmd>q<CR>', 'quit' },
        -- ['<Leader>v'] = { 'gg0vG$', 'select all' },
        ['<Leader>w'] = { '<Cmd>Neoformat|w<CR>', 'write and format' },
        ['<Leader>W'] = { '<Cmd>w<CR>', 'write without formatting' },
    },
    v = {
        ['<Leader>V'] = { '<Esc>ggVG', 'select all lines' },
        -- ['<Leader>v'] = { '<ESC>gg0vG$', 'select all' },
    },
}

M.clipboard = {
    n = {
        -- ['<Leader>D'] = { '"+D', 'delete rest' },
        ['<Leader>P'] = { '"+P', 'paste before' },
        ['<Leader>X'] = { '"+X', 'delete before' },
        ['<Leader>Y'] = { '"+Y', 'yank line' },
        ['<Leader>d'] = { '"+d', 'delete...' },
        -- ['<Leader>p'] = { '"+p', 'paste after' },
        -- ['<Leader>x'] = { '"+x', 'delete char' },
        ['<Leader>y'] = { '"+y', 'yank...' },
    },
    v = {
        ['<Leader>C'] = { '"+C', 'change line' },
        ['<Leader>D'] = { '"+D', 'delete line' },
        ['<Leader>P'] = { '"+P', 'paste' },
        ['<Leader>S'] = { '"+S', 'substitute line' },
        ['<Leader>X'] = { '"+X', 'cut line' },
        ['<Leader>Y'] = { '"+Y', 'yank line' },
        ['<Leader>c'] = { '"+c', 'change' },
        ['<Leader>d'] = { '"+d', 'delete' },
        ['<Leader>p'] = { '"+p', 'paste' },
        ['<Leader>s'] = { '"+s', 'substitute' },
        ['<Leader>x'] = { '"+x', 'cut' },
        ['<Leader>y'] = { '"+y', 'yank' },
    },
}

M.disabled = {
    n = {
        ['<leader>ch'] = '',
        -- ['<leader>D'] = '',
        -- ['<leader>ph'] = '',
        -- ['<leader>pt'] = '',
        -- ['<leader>v'] = '',
        ['<leader>wK'] = '',
        ['<leader>wa'] = '',
        ['<leader>wk'] = '',
        ['<leader>q'] = '',
        ['<leader>wl'] = '',
        ['<leader>wr'] = '',
        -- ['<leader>x'] = '',
    },
}

return M

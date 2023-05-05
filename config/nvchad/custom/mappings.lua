local M = {}

M.general = {
    i = {
        ['<C-Backspace>'] = {'<C-w>', 'erase word before'},
        ['<C-a>'] = {'<ESC>I', 'beginning of line'}
    },
    n = {
        ['<leader>Q'] = {':quitall<CR>', 'quit'},
        ['<leader>V'] = {'ggVG', 'select all lines'},
        ['<leader>q'] = {':quit<CR>', 'quit'},
        ['<leader>v'] = {'gg0vG$', 'select all'},
        ['<leader>w'] = {':write<CR>', 'write'},
    },
    v = {
        ['<leader>V'] = {'<ESC>ggVG', 'select all lines'},
        ['<leader>v'] = {'<ESC>gg0vG$', 'select all'},
    }
}

M.clipboard = {
    n = {
        ['<leader>D'] = {'"+D', 'delete rest'},
        ['<leader>P'] = {'"+P', 'paste before'},
        ['<leader>X'] = {'"+X', 'delete before'},
        ['<leader>Y'] = {'"+Y', 'yank line'},
        ['<leader>d'] = {'"+d', 'delete...'},
        ['<leader>p'] = {'"+p', 'paste after'},
        ['<leader>x'] = {'"+x', 'delete char'},
        ['<leader>y'] = {'"+y', 'yank...'}
    },
    v = {
        ['<leader>C'] = {'"+C', 'change line'},
        ['<leader>D'] = {'"+D', 'delete line'},
        ['<leader>P'] = {'"+P', 'paste'},
        ['<leader>S'] = {'"+S', 'substitute line'},
        ['<leader>X'] = {'"+X', 'cut line'},
        ['<leader>Y'] = {'"+Y', 'yank line'},
        ['<leader>c'] = {'"+c', 'change'},
        ['<leader>d'] = {'"+d', 'delete'},
        ['<leader>p'] = {'"+p', 'paste'},
        ['<leader>s'] = {'"+s', 'substitute'},
        ['<leader>x'] = {'"+x', 'cut'},
        ['<leader>y'] = {'"+y', 'yank'}
    }
}

M.disabled = {
    n = {
        ['<leader>D'] = '',
        ['<leader>ph'] = '',
        ['<leader>pt'] = '',
        ['<leader>v'] = '',
        ['<leader>wK'] = '',
        ['<leader>wa'] = '',
        ['<leader>wk'] = '',
        ['<leader>wl'] = '',
        ['<leader>wr'] = '',
        ['<leader>x'] = ''
    }
}

return M

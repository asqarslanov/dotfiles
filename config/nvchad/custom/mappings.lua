local M = {}

M.disabled = {
    n = {
        ['<leader>ph'] = '',
        ['<leader>pt'] = ''
    }
}

M.clipboard = {
    n = {
        ['<leader>y'] = {'"+y', 'yank...'},
        ['<leader>Y'] = {'"+Y', 'yank line'},
        ['<leader>P'] = {'"+P', 'paste before'},
        ['<leader>p'] = {'"+p', 'paste after'}
    },
    v = {
        ['<leader>y'] = {'"+y', 'yank...'},
        ['<leader>Y'] = {'"+Y', 'yank line'},
        ['<leader>P'] = {'"+P', 'paste before'},
        ['<leader>p'] = {'"+p', 'paste after'}
    }
}

return M

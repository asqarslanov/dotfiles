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
        ['<leader>P'] = {'"+P', 'paste before', opts = { nowait = true }},
        ['<leader>p'] = {'"+p', 'paste after', opts = { nowait = true }}
    },
    v = {
        ['<leader>y'] = {'"+y', 'yank...'},
        ['<leader>Y'] = {'"+Y', 'yank line'},
        ['<leader>P'] = {'"+P', 'paste before', opts = { nowait = true }},
        ['<leader>p'] = {'"+p', 'paste after', opts = { nowait = true }}
    }
}

return M

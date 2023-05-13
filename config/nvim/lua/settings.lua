vim.api.nvim_create_autocmd("TextYankPost", { command = "lua vim.highlight.on_yank()" })

vim.opt.confirm = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.list = true
vim.opt.listchars = { tab = "→  ", trail = "·" }

vim.opt.mouse = "a"
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.whichwrap:append("<>[]hl")

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.shortmess:append("sI")

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.termguicolors = true

vim.opt.undofile = true

vim.opt.wrap = false
vim.opt.linebreak = true

vim.opt.showmode = false
vim.opt.laststatus = 3

vim.g.markdown_recommended_style = 0

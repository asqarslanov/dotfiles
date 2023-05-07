local opt = vim.opt

opt.confirm = true

opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.softtabstop = 4
opt.tabstop = 4

opt.ignorecase = true
opt.smartcase = true

opt.list = true
opt.listchars = { tab = "→  ", trail = "·" }

opt.mouse = "a"
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.whichwrap:append("<>[]hl")

opt.number = true
opt.relativenumber = true

opt.shortmess:append("sI")

opt.splitbelow = true
opt.splitright = true

opt.termguicolors = true

opt.undofile = true

opt.wrap = false
opt.linebreak = true

opt.showmode = false
opt.laststatus = 3

vim.g.markdown_recommended_style = 0

vim.opt.guicursor = ""

-- current mode already shown in statusline
vim.opt.showmode = false

-- line-wrapping but keeps wrapped lines on same indentation level
vim.opt.breakindent = true

-- enable line numbers and make em relative
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

-- preview substitutions live
vim.opt.inccommand = "split"

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.colorcolumn = "120"

-- ignore case when searching
vim.opt.ignorecase = true

-- automatically switch to case-sensitive if a capital letter is used
vim.opt.smartcase = true

-- make new splits go below and to the right of the current pane
vim.cmd("set splitright splitbelow")

-- folds
vim.cmd("set foldcolumn=1")

vim.opt.winblend = 0
vim.opt.winborder = "rounded"

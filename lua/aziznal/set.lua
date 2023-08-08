vim.opt.guicursor = ""

-- enable line numbers and make em relative
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- vim.opt.hlsearch = false
-- vim.opt.incsearch = false

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

-- ignore case when searching
vim.opt.ignorecase = true
-- automatically switch to case-sensitive if a capital letter is used
vim.opt.smartcase = true

-- make new splits go below and to the right of the current pane
vim.cmd("set splitright splitbelow")

-- make vertical split filler just empty (is '|' by default)
-- vim.cmd("set fillchars+=vert:\\ ")

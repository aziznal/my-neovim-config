require("gitblame")

vim.cmd("let g:gitblame_enabled = 0")
vim.cmd("let g:gitblame_message_when_not_committed = ''")
vim.cmd("let g:gitblame_message_template = '<author> - <summary>'")

vim.cmd("GitBlameDisable")

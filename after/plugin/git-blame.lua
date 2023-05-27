local gitblame = require('gitblame')

vim.cmd("let g:gitblame_enabled = 1")
vim.cmd("let g:gitblame_message_when_not_committed = ''")
vim.cmd("let g:gitblame_message_template = '<author> - <summary>'")

local prettier = require('prettier')

-- trigger format
vim.keymap.set('n', '<leader>f', prettier.format)


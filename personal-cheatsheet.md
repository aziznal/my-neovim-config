### Incrementing selected numbers

-

### Change something globally

see [this article](https://thevaluable.dev/vim-search-find-replace/) for a good read.

also this [reddit comment](https://www.reddit.com/r/neovim/comments/i5iptq/comment/g0vpn8j/?utm_source=share&utm_medium=web2x&context=3)

Steps:

1. Look something up with telescope (`<leader>pg`)
2. Move results to quickfix list with `Ctrl-q`
3. Use `:cdo` to apply changes to every entry in your list.

Example: `:cdo s/foo/bar/ge`

Notes:

- the `g` at the causes all occurences to be replaced instead of only the first.
- the `e` stops showing annoying vim errors
- spaces must be escaped: `s/something/with\ somethng\ else/ge`

### Macro magic

- `Q` applies the last applied macro

### Quickfix lists

see [quickfix list docs from neovim](http://neovim.io/doc/user/quickfix.html#quickfix-error-lists)

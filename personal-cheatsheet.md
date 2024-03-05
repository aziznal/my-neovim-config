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

### Repeatable find-and-replace

1. `:/foo` to search for foo
2. `cgn` to change the next word that matches the search
3. dot to repeat the change on the next match

### Macro magic

- `Q` applies the last applied macro

### Quickfix lists

see [quickfix list docs from neovim](http://neovim.io/doc/user/quickfix.html#quickfix-error-lists)

### Number manipulation

- `<C-a>` increments

- `<C-a>`

- `g<C-a>` sequentially increment selected numbers

### Misc

- <alt> with (almost) any key in insert mode interprets that key as in normal mode.
- `*` to find next for word under selection, `#` for backwards find.


### To do list:
- [ ] Learn to work with terminal inside neovim?
- [ ] Master folding


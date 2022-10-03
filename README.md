# vim-clipboard-override

Override Vim registers using system commands.

To main use case is to implement the system clipboard on platforms that are not supported by Vim's `+clipboard`.
For example, to access Android's clipboard on Termux by overriding the `t` register:

```viml
let g:clipboard_override_yank = { "t": "termux-clipboard-set" }
let g:clipboard_override_paste = { "t": "termux-clipboard-get" }
```

The configured yank command is executed immediately after a yank.
The paste command is executed by the `p` and `P` bindings overridden by this plugin. The text typed by `<C-r>` is not uptodate.

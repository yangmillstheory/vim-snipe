# vim-snipe

> Targeted linewise motions and edits

![gif](https://media.giphy.com/media/UXzQDxF7TB1fO/giphy.gif)

1. Jump to a target on the same line with a single keystroke, no matter the distance
2. Quickly fix common typos using swaps, replaces, and cuts

[Read this for background and motivation.](https://blog.yangmillstheory.com/posts/vim-snipe)

The plugin API is exposed via "named key sequences"; see [this write-up](http://whileimautomaton.net/2008/09/27022735) on why this is a good idea.

### Examples

#### Character motion

We want to jump to the last "o" in front of the cursor, but there are several other "o"'s in the way.

```vim
map <leader><leader>f <Plug>(snipe-f)
```

![f](https://user-images.githubusercontent.com/2729079/33584714-80346e28-d915-11e7-875d-fa01d60389a7.gif)

#### Word motion

We want to jump to the end of "to".

```vim
map <leader><leader>ge <Plug>(snipe-ge)
```

![ge](https://user-images.githubusercontent.com/2729079/33569952-2e13b444-d8e0-11e7-950b-ad49c8b55eac.gif)

#### Swap

Fix "smlal" by swapping a previous instance of "l".

```vim
nmap <leader><leader>] <Plug>(snipe-f-xp)
nmap <leader><leader>[ <Plug>(snipe-F-xp)
```

![xp](https://user-images.githubusercontent.com/2729079/33570040-6f51f8c6-d8e0-11e7-935b-627ce9197bef.gif)

#### Cut

Fix "smoall" by cutting an instance of "o".

```vim
nmap <leader><leader>x <Plug>(snipe-f-x)
nmap <leader><leader>X <Plug>(snipe-F-x)
```

![x](https://user-images.githubusercontent.com/2729079/33570110-a36d2e1e-d8e0-11e7-9dc4-4f70f13be3d6.gif)

#### Replace

Fix "smbll" by replacing an instance of "b".

```vim
nmap <leader><leader>r <Plug>(snipe-f-r)
nmap <leader><leader>R <Plug>(snipe-F-r)
```

![r](https://user-images.githubusercontent.com/2729079/33586877-69c799a2-d920-11e7-8286-55470dbbdb3c.gif)

### Options

By default, the jump tokens are row-ordered starting with the home row: `asdfghjklqwertyuiopzxcvbnm`. You can provide your own sequence by setting a global variable `g:snipe_jump_tokens`. For Dvorak users, e.g.

```vim
let g:snipe_jump_tokens = 'aoeuidhtns'
```

You can also provide your own highlighting via

```vim
let g:snipe_highlight_gui_color = '#fabd2f'
let g:snipe_highlight_cterm256_color = '200'
let g:snipe_highlight_cterm_color = 7'
```

These are used to build the highlighting group in [highlight.vim](https://github.com/yangmillstheory/vim-snipe/blob/master/autoload/snipe/highlight.vim) used when highlighting a jump sequence.

### Docs

For the full documentation, do `:h snipe.txt`.

### FAQ

> Why did you constrain to `line('.')`?

Given `set relativenumber`, scanning the buffer is overkill and unnecessarily slow.

> Should I always use this over the built-in motions?

No, in some cases (i.e. a single hop to an adjacent word, or when the target is obviously unique on the path to the cursor), it's probably faster to use the built-in motions.

Pick the right tool for the right job; I use vim-snipe constantly, but I don't remap the built-in motions.

### Inspirations

* [tmux-fingers](https://github.com/Morantron/tmux-fingers)
* [vimium](https://github.com/philc/vimium)
* [vim-easymotion](https://github.com/easymotion/vim-easymotion/)

### Contributing

Pull requests are welcome; no special process is required.

# vim-snipe

> Fast linewise motions and edits

Provides

1. Extensions of `f`, `F`, `t`, `T`, `w`, `W`, `b`, `B` and friends to navigate with one keystroke and minimal cognitive load
    * for example, instead of `fA;;;;`, `3T` or `5e`, you can [press a single highlighted key to reach your target](https://github.com/yangmillstheory/vim-snipe#character-motions), avoiding manual counting
2. Fast ways to fix common typos on the same line, using swaps (`xp`), replacement (`r`), and cuts (`x`)

See [motivation](https://github.com/yangmillstheory/vim-snipe#motivation) and [FAQ](https://github.com/yangmillstheory/vim-snipe#faq) for more.

Inspired by [tmux-fingers](https://github.com/Morantron/tmux-fingers), [vimium](https://github.com/philc/vimium), and [vim-easymotion](https://github.com/easymotion/vim-easymotion/).

### Installing

If you use a plugin manager this is as simple as

```vim
Plug 'yangmillstheory/vim-snipe'
```

The above example uses [vim-plug](https://github.com/junegunn/vim-plug); tweak accordingly for your plugin manager.

### Usage and examples

The plugin API is exposed via "named key sequences"; see [this write-up](http://whileimautomaton.net/2008/09/27022735) on why this is a good idea. For more information, do `:h snipe.txt`.

#### Character motions

Use in Visual, Normal, or Operator-pending mode.

Example mappings:

```vim
map <leader><leader>F <Plug>(snipe-F)
map <leader><leader>f <Plug>(snipe-f)
map <leader><leader>T <Plug>(snipe-T)
map <leader><leader>t <Plug>(snipe-t)
```

Example usage: there are three o's in front of the cursor, and we want to jump to the second one.

![f](https://user-images.githubusercontent.com/2729079/33569729-742db2be-d8df-11e7-8cf3-99547c0edf2b.gif)

#### Word motions

Use in Visual, Normal, or Operator-pending mode.

Example mappings:

```vim
map <leader><leader>w <Plug>(snipe-w)
map <leader><leader>W <Plug>(snipe-W)
map <leader><leader>e <Plug>(snipe-e)
map <leader><leader>E <Plug>(snipe-E)
map <leader><leader>b <Plug>(snipe-b)
map <leader><leader>B <Plug>(snipe-B)
map <leader><leader>ge <Plug>(snipe-ge)
map <leader><leader>gE <Plug>(snipe-gE)
```

Example usage: jump to the end of the 6th preceding `<word>`.

![ge](https://user-images.githubusercontent.com/2729079/33569952-2e13b444-d8e0-11e7-950b-ad49c8b55eac.gif)

#### Edits

Use in Normal mode.

##### Swap `xp`

Example mappings:

```vim
nmap <leader><leader>] <Plug>(snipe-f-xp)
nmap <leader><leader>[ <Plug>(snipe-f-xp)
```

Usage: Change the typo "smlal" to "small" by swapping a previous instance of "l".

![xp](https://user-images.githubusercontent.com/2729079/33570040-6f51f8c6-d8e0-11e7-935b-627ce9197bef.gif)

##### Cut `x`

Example mappings:

```vim
nmap <leader><leader>x <Plug>(snipe-f-x)
nmap <leader><leader>X <Plug>(snipe-F-x)
```

Example usage: Change the typo "smoall" to "small" by cutting an instance of "o", which occurs before the cursor.

![x](https://user-images.githubusercontent.com/2729079/33570110-a36d2e1e-d8e0-11e7-9dc4-4f70f13be3d6.gif)

##### Replace `r`

```vim
nmap <leader><leader>r <Plug>(snipe-f-r)
nmap <leader><leader>R <Plug>(snipe-F-r)
```

Example usage: Change the typo "smell" to "small" by replacing an instance of "o", which occurs before the cursor.

![r](https://user-images.githubusercontent.com/2729079/33570877-20c3f6d4-d8e3-11e7-86c1-857c4a293b72.gif)


### Configuration

By default, the jump tokens are ordered starting with the home row 'asdfghjkl', then 'qwertyuiop', then 'zxcvbnm'.

You can provide your own sequence by setting a global variable `g:snipe_jump_tokens`. For Dvorak users, e.g.

```vim
let g:snipe_jump_tokens = 'aoeuidhtns'
```

### Motivation

**1. Automate fixing typos on the same line.**

I make mistakes often enough to make this worth automating - in fact, I made a few mistakes while writing this line.

**2. No more `;` and `,` repetition when using linewise motions.**

I almost always know where I want to go, but I'm forced to navigate incrementally to that place, or manually count the prefix of the motion (i.e. `5e`).

**3. There aren't any plugins containing or focused on the same feature set.**

The two plugins with the most overlap in functionality are

* [Stupid-EasyMotion](https://github.com/joequery/Stupid-EasyMotion)
* [vim-easymotion](https://github.com/easymotion/vim-easymotion)

Stupid-Easymotion constrains motions to `line('.')`, but it only provides mappings for `f`, `w`, and `W`. It also hasn't seen any activity in a long time - 4+ years at the time of this writing.

[vim-easymotion has a similarly incomplete API](https://github.com/easymotion/vim-easymotion/issues/354). It's also
[sprawling](https://www.reddit.com/r/vim/comments/1v9qyu/actively_developed_and_maintained_fork_of/ceq7lcf/), and (IMHO)
painful to extend.

However, I'd like to give credit to vim-easymotion, having borrowed some core functionality and logic:

* highlighting initialization
* clever algorithm for building the jump tree


### FAQ

> Why did you constrain to `line('.')`?

There's no need to scan the whole buffer, given `set relativenumber`. Thus, this approach is more performant and IMHO more natural.

> But I've been getting by just fine without this!

Cool, then you shouldn't use it. I use it everyday, so it serves me well, and hopefully I'm not the only one.

> Should I always use the mappings?

No, in some cases (i.e. a single hop to an adjacent word, or when the destination character is unique on the path to the cursor), it's probably faster to use `f`, `F`, `t`, `T`, etc. Pick the right tool for the right job, I'd say.

### Contributing

Pull requests are welcome; no special process is required. Currently there's no optionality for the highlighting format, for example.

I'm sure there's also plenty of bugs which I won't have the time or inclination to always fix (try using the plugin when browsing Vim documentation, e.g.).

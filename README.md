# vim-snipe

> Fast linewise motions and edits

Provides

1. Extensions of `f`, `F`, `t`, `T`, `w`, `W`, `b`, `B` and friends to navigate with one keystrokes and minimal cognitive load
    * for example, instead of `fA;;;;`, `3T` or `5e`, you can [press a single highlighted key to reach your target](https://github.com/yangmillstheory/vim-snipe#character-motions), avoiding tedium
2. Ways to fix common typos on the same line, using swaps (`xp`), replacement (`r`), and cuts (`x`)

See [motivation](https://github.com/yangmillstheory/vim-snipe#motivation) and [FAQ](https://github.com/yangmillstheory/vim-snipe#faq) for more.

### Installing

If you use a plugin manager this is as simple as

```vim
Plug 'yangmillstheory/vim-snipe'
```

The above example uses [vim-plug](https://github.com/junegunn/vim-plug); tweak accordingly for your plugin manager.

### Docs

`:h snipe.txt`

### Usage and examples

The plugin API is exposed via "named key sequences"; see [this write-up](http://whileimautomaton.net/2008/09/27022735) on why this is a good idea.

#### Character motions

Use in Visual, Normal, or Operator-pending mode.

```vim
map <leader><leader>F <Plug>(snipe-F)
map <leader><leader>f <Plug>(snipe-f)
map <leader><leader>T <Plug>(snipe-T)
map <leader><leader>t <Plug>(snipe-t)
```

![f](https://user-images.githubusercontent.com/2729079/33415309-7fc23138-d54a-11e7-9c02-a48e84ee4f8a.gif)

#### Word motions

Use in Visual, Normal, or Operator-pending mode.

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

![ge](https://user-images.githubusercontent.com/2729079/33415310-84d2ff72-d54a-11e7-8572-70e7292b123e.gif)

#### Edits

Use in Normal mode.

##### Swap `xp`

```vim
nmap <leader><leader>] <Plug>(snipe-f-xp)
nmap <leader><leader>[ <Plug>(snipe-f-xp)
```

![xp](https://user-images.githubusercontent.com/2729079/33415312-8af8eb64-d54a-11e7-920a-c14069b25704.gif)

##### Cut `x`

```vim
nmap <leader><leader>x <Plug>(snipe-f-x)
nmap <leader><leader>X <Plug>(snipe-F-x)
```

![x](https://user-images.githubusercontent.com/2729079/33415315-8e209210-d54a-11e7-9dfa-b9a6701901d6.gif)

##### Replace `r`

```vim
nmap <leader><leader>r <Plug>(snipe-f-r)
nmap <leader><leader>R <Plug>(snipe-F-r)
```

![r](https://user-images.githubusercontent.com/2729079/33415316-9181c618-d54a-11e7-80bb-2c72b34f3e11.gif)

### Motivation

**1. Automate fixing typos on the same line.**

I make mistakes often enough to make this worth automating - in fact, I made a few mistakes while writing this line.

**2. No more `;` and `,` repetition when using linewise motions.**

I almost always know where I want to go, but I'm forced to navigate incrementally to that place.

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

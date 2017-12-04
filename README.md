# vim-snipe

> Fast linewise motions and edits

### Why

1. I want to minimize repetition when correcting typing mistakes on the same line.
2. I don't like the `;` and `,` repetition when using linewise motions.

There aren't any plugins with the same feature set. The two plugins with the most overlap in functionality are

1. [Stupid-EasyMotion](https://github.com/joequery/Stupid-EasyMotion)
2. [vim-easymotion](https://github.com/easymotion/vim-easymotion)

1 is no longer active, and is a simple fork of 2. While it agrees with this effort in spirit (constraining motions to `line('.')`), it
only provides mappings for `f`, `w`, and `W`. It also hasn't seen any activity in a while.

2 also has a similarly incomplete API at the time of this writing; see [this issue](https://github.com/easymotion/vim-easymotion/issues/354).
It's also monolithic, sprawling, and painful to extend. See [this Reddit thread](https://www.reddit.com/r/vim/comments/1v9qyu/actively_developed_and_maintained_fork_of/ceq7lcf/)
for more discussion.

### Installing

If you use a plugin manager this is as simple as

```vim
Plug 'yangmillstheory/vim-snipe'
```

The above example uses [vim-plug](https://github.com/junegunn/vim-plug); tweak accordingly for your plugin manager.

### Usage

Note that all motions below (except cutting, swapping, and replacing) work in character, visual and operator-pending modes.

#### Character motions

```vim
map <leader><leader>F <Plug>(snipe-F)
map <leader><leader>f <Plug>(snipe-f)
map <leader><leader>T <Plug>(snipe-T)
map <leader><leader>t <Plug>(snipe-t)
```

![f](https://user-images.githubusercontent.com/2729079/33415309-7fc23138-d54a-11e7-9c02-a48e84ee4f8a.gif)

#### Word motions

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


#### Swap `xp`

```vim
nmap <leader><leader>] <Plug>(snipe-f-xp)
nmap <leader><leader>[ <Plug>(snipe-f-xp)
```

![xp](https://user-images.githubusercontent.com/2729079/33415312-8af8eb64-d54a-11e7-920a-c14069b25704.gif)

#### Cut `x`

```vim
nmap <leader><leader>x <Plug>(snipe-f-x)
nmap <leader><leader>X <Plug>(snipe-F-x)
```

![x](https://user-images.githubusercontent.com/2729079/33415315-8e209210-d54a-11e7-9dfa-b9a6701901d6.gif)

#### Replace `r`


```vim
nmap <leader><leader>r <Plug>(snipe-f-r)
nmap <leader><leader>R <Plug>(snipe-F-r)
```

![r](https://user-images.githubusercontent.com/2729079/33415316-9181c618-d54a-11e7-80bb-2c72b34f3e11.gif)

### Documentation

`:h snipe.txt`

### FAQ

> But doesn't [vim-easymotion](https://github.com/easymotion/vim-easymotion/) do the same thing?

[No](https://github.com/easymotion/vim-easymotion/issues/354), and [it does too much.](https://www.reddit.com/r/vim/comments/1v9qyu/actively_developed_and_maintained_fork_of/ceq7lcf/)

> But why didn't you extend it instead?

After looking at the code, it's indeed monolithic, large, sprawling, and (in my opinion) painful and unpleasant to extend. However, [one of the core algorithms is similar](https://github.com/easymotion/vim-easymotion/pull/359).

> How is it different?

* [all common word motions are supported](https://github.com/easymotion/vim-easymotion/issues/354)
* all motions are constrained on `line('.')`, because
  * this is more natural
  * this is more performant
  * there's no need to scan the entire buffer given `set relativenumber`
* there are motions for singe-character replacements, cuts, and swaps - which is my most common use case

### Contributing

Pull requests are welcome; no special process is required.
